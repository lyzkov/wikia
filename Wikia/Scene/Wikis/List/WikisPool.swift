//
//  WikisPool.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

final class WikisPool: DataPool {
    typealias DataRequest = WikiaAPI.Wikis

    func list(batch: UInt = 1) -> Single<Batch<Wiki>> {
        return decodedData(from: .list(limit: Batch<Wiki>.limit, batch: batch))
    }
    
}
