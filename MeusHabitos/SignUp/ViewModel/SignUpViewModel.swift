//
//  SignUpViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 28/01/26.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
  
  @Published var fullName = ""
  @Published var email = ""
  @Published var password = ""
  @Published var document = ""
  @Published var phone = ""
  @Published var birthday = ""
  @Published var gender = Gender.male
  
  var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
  
  @Published var uiState: SignUpUIState = .none
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
  
  func signUp() {
    self.uiState = .loading
    
    // Pegar a String -> dd/MM/yyyy -> Date
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "dd/MM/yyyy"
    
    let dateFormatted = formatter.date(from: birthday)
    
    // Validar a Data
    guard let dateFormatted = dateFormatted else {
      self.uiState = .error("Data inválida \(birthday)")
      return
    }
    
    // Date -> yyyy-MM-dd -> String
    formatter.dateFormat = "yyyy-MM-dd"
    let birthday = formatter.string(from: dateFormatted)
    
    let signUpRequest = SignUpRequest(fullName:  fullName,
                                      email: email,
                                      password: password,
                                      document: document,
                                      phone: phone,
                                      birthday: birthday,
                                      gender: gender.index)
      
      cancellableSignUp = interactor.postUser(sigUpRequest: signUpRequest)
          .receive(on: DispatchQueue.main)
          .sink { completion in
              switch(completion) {
              case .failure(let appError):
                  self.uiState = .error(appError.message)
                  break
              case .finished:
                  break
              }
          } receiveValue: { created in
              if (created) {
                  
                  self.cancellableSignIn = self.interactor.login(sigInRequest: SignInRequest(email: self.email, password: self.password))
                      .receive(on: DispatchQueue.main)
                      .sink { completion in
                          switch(completion) {
                          case .failure(let appError):
                              break
                          case .finished:
                              break
                          }
                      } receiveValue: { sucess in
                          print(created)
                          
                          let auth = UserAuth(idToken: sucess.acessToken,
                                              refreshToken: sucess.refreshToken,
                                              expires: Date().timeIntervalSince1970 + Double(sucess.expires),
                                              tokenType: sucess.tokenType)
                          self.interactor.insertAuth(userAuth: auth)
                          
                          self.publisher.send(created)
                          self.uiState = .success
                      }
              }
          }
  }
}

extension SignUpViewModel {
  func homeView() -> some View {
    return SignUpViewRouter.makeHomeView()
  }
}
