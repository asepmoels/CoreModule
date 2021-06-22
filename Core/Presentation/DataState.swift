//
//  DataState.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation

public enum DataState<Model> {
  case initialized
  case loading
  case loaded(data: Model)
  case empty
  case failed(error: Error)

  public var value: Model? {
    if case .loaded(let data) = self {
      return data
    }
    return nil
  }

  public var error: Error? {
    if case .failed(let error) = self {
      return error
    }
    return nil
  }
}
