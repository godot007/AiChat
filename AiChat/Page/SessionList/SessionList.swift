//
//  SessionList.swift
//  AiChat
//
//  Created by Roy on 6/1/2025.
//

import SwiftUI

struct SessionList: View {
  @StateObject private var model = SessionListModel()
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      NavigationView {
        List(model.listData) { session in
          NavigationLink {
            ChatRoom(session: session, listModel: model)
              .navigationBarTitle(session.title, displayMode: .inline)
          } label: {
            SessionRow(session: session)
              .swipeActions {
                Button(role: .destructive) {
                  model.deleteSession(with: session.id)
                } label: {
                  Label("Delete", systemImage: "trash.fill")
                }
              }
          }
          .listRowSeparator(.hidden)
        }
        .navigationBarTitle("Sessions", displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button(action: addItem) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }
        .listStyle(.plain)
      }
    } else {
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
            .navigationBarTitle(model.selection!.title, displayMode: .inline)
        }
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
