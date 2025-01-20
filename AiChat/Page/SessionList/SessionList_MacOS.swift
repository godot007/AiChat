//
//  SessionList_MacOS.swift
//  AiChat
//
//  Created by Roy on 2025/1/20.
//

import SwiftUI

struct SessionList: View {
  @StateObject private var model = SessionListModel()
  
  var body: some View {
    NavigationSplitView {
      List(model.listData) { session in
        SessionRow(session: session)
          .swipeActions {
            Button(role: .destructive) {
              model.deleteSession(with: session.id)
            } label: {
              Label("Delete", systemImage: "trash.fill")
            }
          }
          .onTapGesture {
            model.selection = session
          }
          .listRowBackground(session == model.selection ? Color.white: Color.clear)
      }
      .toolbar {
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      if model.selection == nil  {
        Text("Deepseek V3").font(.title)
      } else {
        ChatRoom(session: model.selection!, listModel: model)
      }
    }
  }
  
  private func addItem() {
    withAnimation {
      model.addSession()
    }
  }
}

struct SessionList_Previews: PreviewProvider {
  static var previews: some View {
    SessionList()
  }
}
