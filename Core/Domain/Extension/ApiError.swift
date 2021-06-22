//
//  ApiError.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation

public enum ApiError: Error {
  case networkFailure(error: Error)
  case invalidServerResponse(responseString: String)
  case failedMapping(json: [String: Any])

  public var localizedDescription: String {
    switch self {
    case .networkFailure(let error):
      return error.localizedDescription
    case .invalidServerResponse(let responseString):
      return "Invalid response: \(responseString)"
    case .failedMapping(let from):
      return "Failed mapping object from \(from)"
    }
  }
}
