//
//  Session.swift
//  AiChat
//
//  Created by Roy on 2025/1/7.
//

import Foundation
import Combine

class Session: ObservableObject, Identifiable, Hashable {
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
  
  static func == (lhs: Session, rhs: Session) -> Bool {
    return lhs.id.uuidString == rhs.id.uuidString
  }
  
  enum Status {
    case normal
    case edit
    case temp
    case destroy
  }
  
  let id: UUID
  var status: Status
  
  @Published var title: String
  @Published var lastUpdated: Date
  @Published var messages: [Message] = []
  
  init(lastUpdated: Date, title: String? = nil, isValid: Bool = false) {
    self.id = UUID()
    self.title = title ?? self.id.uuidString
    self.lastUpdated = lastUpdated
    self.status = .temp
  }
  
  func sendMessage(_ chatMessage: Message) {
    self.lastUpdated = chatMessage.createdTime
    self.messages.append(chatMessage)
    self.status = .normal
  }
  
}
