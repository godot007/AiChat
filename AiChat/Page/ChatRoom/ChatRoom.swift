//
//  ChatRoom.swift
//  AiChat
//
//  Created by Roy on 5/1/2025.
//

import SwiftUI

struct ChatRoom: View {
  
  enum FocusedField {
    case messageField
  }
  
  @FocusState private var focusedField: FocusedField?
  
  @ObservedObject var session: Session
  @ObservedObject var listModel: SessionListModel
  
  @State var typingMessage: String = ""
  @State var isLoading: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      List(session.messages) { msg in
          MessageView(currentMessage: msg)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
//#if os(macOS)
//        Color.clear.frame(height: 20)
//          .listRowSeparator(.hidden)
//#endif
      }
      .listStyle(.plain)
      ZStack {
        HStack {
          TextField("message", text: $typingMessage)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .focused($focusedField, equals: .messageField)
            .onSubmit {
              focusedField = nil
              sendMessage()
            }
          if isLoading {
            ProgressView()
              .frame(width: 50)
#if os(macOS)
              .scaleEffect(0.68)
#endif
          } else {
            Button(action: sendMessage) {
              Text("send")
            }.frame(width: 50)
          }
        }
        .frame(height: 52)
        .padding(.horizontal, 16)
        .background(Color.white)
      }
      .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -2)
    }
    .background(.white)
  }
  
  func sendMessage() {
    if typingMessage == "" {
      return
    }
    withAnimation {
      let sendTime = Date()
      session.sendMessage(Message(content: typingMessage, user: User.client, createdTime: sendTime))
      listModel.updateSessionsHash()
      let curUsrMsgs = session.messages.filter { $0.user.isCurrentUser }.map { $0.content }
      Task {
        isLoading = true
        let dpAnswer = await DeepseekHelper.fetchAnswer(curUsrMsgs)
        let receivingTime = Date()
        session.sendMessage(Message(content: dpAnswer, user: User.bot, createdTime: receivingTime))
        listModel.updateSessionsHash()
        isLoading = false
        print(dpAnswer)
      }
      typingMessage = ""
    }
  }
}

struct ChatRoom_Previews: PreviewProvider {
  static var previews: some View {
    ChatRoom(session: Session(lastUpdated: Date()), listModel: SessionListModel())
  }
}
