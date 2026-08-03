//
//  SignInErrorResponse.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 17/03/26.
//

import Foundation

struct SignInErrorResponse: Decodable {
    
    let detail: SignInDetailResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailResponse: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
