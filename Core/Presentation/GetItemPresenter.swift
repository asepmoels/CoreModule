//
//  GetItemPresenter.swift
//  Core
//
//  Created by Asep Mulyana on 21/06/21.
//

import Foundation
import RxSwift
import RxRelay

public class GetItemPresenter<Request, Response, Interactor: UseCase>
  where Interactor.Request == Request, Interactor.Response == Response {

  private let disposeBag = DisposeBag()
  private let useCase: Interactor

  public var item: BehaviorRelay<DataState<Response>> = BehaviorRelay.init(value: .initialized)

  public init(useCase: Interactor) {
    self.useCase = useCase
  }

  public func getItem(request: Request?) {
    item.accept(.loading)
    useCase.execute(request: request)
      .subscribe(onNext: { [weak self] (data) in
        self?.item.accept(.loaded(data: data))
      }, onError: { (error) in
        self.item.accept(.failed(error: error))
      })
      .disposed(by: disposeBag)
  }
}
