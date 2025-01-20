//
//  SessionRow.swift
//  AiChat
//
//  Created by Roy on 2025/1/14.
//

import SwiftUI

struct SessionRow: View {
  
  @ObservedObject var session: Session
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(session.title)
        .foregroundStyle(Color(hex: "#333"))
        .font(.system(size: 15))
        .padding(.bottom, 2)
      Text(session.lastUpdated.string)
        .foregroundStyle(Color(hex: "#999"))
        .font(.system(size: 12))
    }
  }
}

struct SessionRow_Preview: PreviewProvider {
  static var previews: some View {
    SessionRow(session: Session(lastUpdated: Date()))
  }
}
