//
//  Respository.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation
import RxSwift

public protocol Repository {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> Observable<Response>
}
