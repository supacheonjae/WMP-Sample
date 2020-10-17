//
//  AppStoreViewModel.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppStoreViewModel: NSObject {
    
    private let apiClient = APIClient()
    private let termObservable: Observable<String>
    
    lazy var rx_appInfos = fetchAppInfos()
    
    
    init(termObservable: Observable<String>) {
        self.termObservable = termObservable
    }
    
    private func fetchAppInfos() -> Driver<[AppInfo]> {
        return termObservable
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { AppStoreRequest(term: $0) }
            .flatMapLatest { [weak self] request -> Observable<AppInfoResults> in
                return self?.apiClient.send(apiRequest: request) ?? .empty()
            }
            .map { $0.results }
            .asDriver(onErrorJustReturn: [])
    }
}
