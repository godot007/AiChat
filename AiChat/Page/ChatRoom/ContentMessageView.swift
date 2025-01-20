//
//  ContentMessageView.swift
//  AiChat
//
//  Created by Roy on 5/1/2025.
//


import SwiftUI

struct ContentMessageView: View {
  var contentMessage: String
  var isCurrentUser: Bool
  var msgTime: Date
  
  var body: some View {
    VStack(alignment: isCurrentUser ? .trailing : .leading) {
      Text(contentMessage)
        .padding(10)
        .foregroundColor(isCurrentUser ? Color.white : Color.black)
        .background(isCurrentUser ? Color.blue : Color(hex: "#efefef"))
        .cornerRadius(10)
        .textSelection(.enabled)
      Text(msgTime.string).font(.system(size: 12)).foregroundColor(Color(hex: "#999")).padding(.horizontal, 10)
    }
  }
}

struct ContentMessageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentMessageView(contentMessage: "Hi, I am your friend", isCurrentUser: false, msgTime: Date())
  }
}
