//
//  DateHelper.swift
//  AiChat
//
//  Created by Roy on 2025/1/13.
//

import Foundation

extension Date {
  
  static let dateFormatter = DateFormatter()
  
  var string: String {
    Date.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return Date.dateFormatter.string(from: self)
  }
  
}

extension String {
  static let dateFormatter = DateFormatter()
  var date: Date? {
    return String.dateFormatter.date(from: self)
  }
}
