import SwiftUI

struct MessageView : View {
  var currentMessage: Message
  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      if !currentMessage.user.isCurrentUser {
        Image(systemName: "cpu")
          .resizable()
          .frame(width: 40, height: 40, alignment: .center)
          .cornerRadius(20)
      } else {
        Spacer()
      }
      ContentMessageView(contentMessage: currentMessage.content,
                         isCurrentUser: currentMessage.user.isCurrentUser, msgTime: currentMessage.createdTime)
    }
    .padding(.vertical, 5)
  }
}

struct MessageView_Previews: PreviewProvider {
  static var previews: some View {
    MessageView(currentMessage: Message(content: "Hi, I am your friend", user: User.bot, createdTime: Date()))
  }
}
