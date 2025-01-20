//
//  Message.swift
//  AiChat
//
//  Created by Roy on 5/1/2025.
//


import Foundation

struct Message: Hashable, Identifiable {
  
  let id = UUID()
  
  var content: String
  var user: User
  var createdTime: Date
  
  static let wlcTip = "Enter the chat content in the input box below"
}
