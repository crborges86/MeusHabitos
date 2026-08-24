//
//  ProfileRequest.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 19/08/26.
//

import Foundation

struct ProfileRequest: Encodable {
  
  let fullName: String
  let phone: String
  let birthday: String
  let gender: Int
  
  enum CodingKeys: String, CodingKey {
    case fullName = "name"
    case phone
    case birthday
    case gender
  }
}
