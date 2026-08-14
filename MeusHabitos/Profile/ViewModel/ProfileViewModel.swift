//
//  ProfileViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 13/08/26.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser(){
        
        self.uiState = .loading
        cancellable = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue:  { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                
                // Pegar a String -> dd/MM/yyyy -> Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                // Validar a Data
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data inválida \(response.birthday)")
                  return
                }
                
                // Date -> yyyy-MM-dd -> String
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                self.birthdayValidation.value = birthday
                
                
                self.uiState = .fetchSuccess
                
            })
    }
    
}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "Teste" {
        didSet {
            failure = value.count < 3
        }
    }
}


class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "11909090909" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "20/10/1980" {
        didSet {
            failure = value.count != 10
        }
    }
}
