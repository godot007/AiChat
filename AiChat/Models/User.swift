//
//  User.swift
//  AiChat
//
//  Created by Roy on 5/1/2025.
//


import Foundation

struct User: Hashable {
  var name: String
  var avatar: String
  var isCurrentUser: Bool = false
  
  static let bot = User(name: "Bot", avatar: "cpu")
  static let client = User(name: "Client", avatar: "client", isCurrentUser: true)
}
