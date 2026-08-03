//
//  SignInViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 09/01/26.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
  
  private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
  
  private let publisher = PassthroughSubject<Bool, Never>()
  private let interactor: SignInInteractor
  
  @Published var uiState: SignInUIState = .none
  
    init(interactor: SignInInteractor) {
    self.interactor = interactor
        
    cancellable = publisher.sink { value in
      print("usuário criado! goToHome: \(value)")
      
      if value {
        self.uiState = .goToHomeScreen
      }
    }
  }
  
  deinit {
    cancellable?.cancel()
    cancellableRequest?.cancel()
  }
  
    
  func login() {
    self.uiState = .loading
      
      cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email,
                                                                        password: password))
                       
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch(completion) {
            case .failure(let appError):
                self.uiState = SignInUIState.error(appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { sucess in
            let auth = UserAuth(idToken: sucess.acessToken,
                                refreshToken: sucess.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(sucess.expires),
                                tokenType: sucess.tokenType)
            self.interactor.insertAuth(userAuth: auth)
            self.uiState = .goToHomeScreen
        }
                       
//      interactor.login(loginRequest: SignInRequest(email: email,
//                                              password: password)) { (sucessResponse, errorResponse) in
//          
//          if let error = errorResponse {
//              DispatchQueue.main.async{
//                  self.uiState = .error(error.detail.message)
//              }
//          }
//          
//          if let sucess = sucessResponse {
//              DispatchQueue.main.async{
//                  print(sucess)
//                  self.uiState = .goToHomeScreen
//                  }
//              }
//          }
      }

  }

extension SignInViewModel {
  func homeView() -> some View {
    return SignInViewRouter.makeHomeView()
  }
  func signUpView() -> some View {
    return SignInViewRouter.makeSignUpView(publisher: publisher)
  }
}
