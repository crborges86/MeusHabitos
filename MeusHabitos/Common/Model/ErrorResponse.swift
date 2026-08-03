//
//  ErrorResponse.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 06/03/26.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
