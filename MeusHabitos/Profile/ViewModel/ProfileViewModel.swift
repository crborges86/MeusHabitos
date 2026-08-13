//
//  ProfileViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 13/08/26.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {

    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "" {
        didSet {
            failure = value.count < 3
        }
    }
}


class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure: Bool = false

    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}
