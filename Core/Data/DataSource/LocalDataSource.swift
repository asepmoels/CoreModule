//
//  LocalDataSource.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation
import RxSwift

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response

  func list(request: Request?) -> Observable<[Response]>
  func add(entity: Response) -> Observable<Response>
  func delete(entity: Response) -> Observable<Response>
  func get(entityId: Int) -> Response?
}
