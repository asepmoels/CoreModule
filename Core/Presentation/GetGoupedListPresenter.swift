//
//  GetGoupedListPresenter.swift
//  Core
//
//  Created by Asep Mulyana on 22/06/21.
//

import Foundation
import RxSwift
import RxRelay

public class GetGoupedListPresenter<Request, Response, Interactor: UseCase>
  where Interactor.Request == Request, Interactor.Response == [Response] {

  private let disposeBag = DisposeBag()
  private let useCase: Interactor
  private let group: Request

  public var list: BehaviorRelay<DataState<[Response]>> = BehaviorRelay.init(value: .initialized)

  public init(useCase: Interactor, group: Request) {
    self.useCase = useCase
    self.group = group
  }

  public func getList(request: Request?) {
    list.accept(.loading)
    useCase.execute(request: group)
      .subscribe(onNext: { [weak self] (data) in
        if data.count > 0 {
          self?.list.accept(.loaded(data: data))
        } else {
          self?.list.accept(.empty)
        }
      }, onError: { (error) in
        self.list.accept(.failed(error: error))
      })
      .disposed(by: disposeBag)
  }
}
