//
//  Gender.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 28/01/26.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable{
    case male = "Masculino"
    case female = "Feminino"
    case undefined = "Indefinido"
    
    var id: String{
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex { self == $0 } ?? 0
    }
}
