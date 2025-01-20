//
//  ChatHelper.swift
//  AiChat
//
//  Created by Roy on 5/1/2025.
//


import Foundation
import Combine

class SessionListModel: ObservableObject, Identifiable {
  
  @Published var sessions: [Session] = []
  @Published var sessionsHash: Int = 0 {
    didSet {
      print("xxxx--sessionsHash--: \(oldValue)-\(sessionsHash)")
    }
  }
  
  enum SortType {
    case createTime
    case lastUpdate
  }
  @Published var sortType: SortType = .lastUpdate
  
  @Published var selection: Session? = nil
  
  init() {
    removeInvalidItems()
    if sessions.isEmpty {
      addSession()
    }
  }
  
  var listData: [Session] {
    let displays = sessions.filter({ $0.status != .destroy })
    if sortType == .lastUpdate {
      return displays.sorted(by: { $0.lastUpdated > $1.lastUpdated })
    }
    return displays
  }

  func addSession() {
    sessions.removeAll{ $0.status == .temp || $0.status == .destroy }

    let now = Date()
    let wlcMessage = Message(content: Message.wlcTip, user: User.bot, createdTime: now)
    let session = Session(lastUpdated: now)
    session.messages.append(wlcMessage)

    sessions.append(session)
  }
  
  func deleteSession(with sessionId: UUID) {
    let session = sessions.first{ $0.id == sessionId }
    session?.status = .destroy
    sessions.removeAll { $0.status == .destroy }
  }
  
  func updateSessionsHash() {
    if sessions.isEmpty {
      return
    }
    let sorteds = sessions.sorted(by: { $0.lastUpdated > $1.lastUpdated })
    sessionsHash = sorteds.map({$0.id}).hashValue
  }
  
  func removeInvalidItems() {
    sessions.removeAll{ $0.status == .destroy }
  }
}
