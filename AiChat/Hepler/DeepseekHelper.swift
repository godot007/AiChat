//
//  DeepSeekResponse.swift
//  AiChat
//
//  Created by Roy on 4/1/2025.
//


import Foundation

let deepseekHost = "https://api.deepseek.com/chat/completions"
let apiKey = "sk-d80dc7ed088d4e84b164907ee9356f01"


struct DeepSeekResponse: Codable {
  let choices: [Choice]
  
  struct Choice: Codable {
    let message: Message
    
    struct Message: Codable {
      let role: String
      let content: String
    }
  }
}

enum DeepseekHelper {
  
  static func fetchAnswer(_ askMsgs: [String]) async -> String {
    do {
      let messages = askMsgs.map { ["role": "system", "content": $0]}
      let requestBody: [String: Any] = ["model": "deepseek-chat", "messages": messages, "stream": false]
      let data = try await Fetch.fetchData(from: deepseekHost, headers: ["Authorization" : "Bearer \(apiKey)", "Content-Type": "application/json"], requestBody: requestBody)
      
      let decoder = JSONDecoder()
      do {
        let dpRespone = try decoder.decode(DeepSeekResponse.self, from: data)
        let dpAnswer = dpRespone.choices.last?.message.content
        return dpAnswer ?? "Data model mismatch, please update the App to the latest version."
      } catch {
        throw NetworkError.decodingError(error)
      }
    } catch {
      switch error {
      case NetworkError.invalidResponse:
        return "invalid response: \(error.localizedDescription)"
      case NetworkError.decodingError:
        return "decoding error: \(error.localizedDescription)"
      default:
        return error.localizedDescription
      }
    }
  }
  
}
