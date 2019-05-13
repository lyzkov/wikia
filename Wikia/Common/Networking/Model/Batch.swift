//
//  Batch.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

struct Batch<Item: Decodable>: Decodable {

    let items: [Item]
    let next: Int
    let batches: UInt
    let currentBatch: UInt
    
}

extension Batch: Paginable {

    static var limit: UInt { return 25 }

    var index: UInt {
        return currentBatch
    }

    var hasNext: Bool {
        return next > 0
    }

}
