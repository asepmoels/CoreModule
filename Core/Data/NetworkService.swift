//
//  NetworkService.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation
import ObjectMapper
import Alamofire
import RxSwift

public class NetworkService {
  public static let shared = NetworkService()

  public func connect<T: Mappable>(api: URL, responseType: T.Type) -> Observable<T> {
    let subject = ReplaySubject<T>.createUnbounded()
    AF.request(api.absoluteString)
      .responseJSON { (response) in
        switch response.result {
        case .success(let json):
          if let data = json as? [String: Any] {
            let map = Map(mappingType: .fromJSON, JSON: data)
            if let object = responseType.init(map: map) {
              subject.onNext(object)
              subject.onCompleted()
            } else {
              subject.onError(ApiError.failedMapping(json: data))
            }
          } else {
            subject.onError(ApiError.invalidServerResponse(responseString: "Not a JSON"))
          }
        case .failure(let error):
          subject.onError(error)
        }
      }
    return subject
  }
}