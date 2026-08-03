//
//  RefreshRequest.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 16/06/26.
//

import Foundation

struct RefreshRequest: Encodable {
  
    let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "refresh_token"
  }
}
