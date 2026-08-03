//
//  Date+Extension.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 15/07/26.
//

import Foundation

extension Date {
  
  func toString(destPattern dest: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = dest
    
    return formatter.string(from: self)
  }
  
}
