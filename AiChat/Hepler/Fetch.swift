//
//  Fetch.swift
//  AiChat
//
//  Created by Roy on 4/1/2025.
//


import Foundation

enum Fetch {
  
  static func fetchData(from urlString: String, headers: [String: String]? = nil, requestBody: [String: Any]? = nil) async throws -> Data {
    
    // url
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // Headers
    if let headers = headers {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }
    
    if let requestBody = requestBody {
      let jsonbody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
      request.httpBody = jsonbody
    }
    
    // resume
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // check HTTP-status
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }
    
    return data
  }
}

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case decodingError(Error)
}
