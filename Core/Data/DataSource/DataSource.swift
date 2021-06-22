//
//  DataSource.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation
import RxSwift

public protocol DataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> Observable<Response>
}
