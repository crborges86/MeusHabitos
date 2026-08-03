//
//  AppError.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 19/03/26.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self{
            case .response(let message):
            return message
        }
    }
}
