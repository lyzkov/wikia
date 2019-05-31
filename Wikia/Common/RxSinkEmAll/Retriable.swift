//
//  Retriable.swift
//  Wikia
//
//  Created by BOGU$ on 31/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

protocol Retriable {
    var shouldRetry: Bool { get }
}

protocol RetriableErrorFiring: ErrorFiring where Error == Retriable & Swift.Error {
}
