//
//  LogErrorHandler.swift
//  Wikia
//
//  Created by BOGU$ on 29/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

protocol LogErrorFiring: ErrorFiring where Error == Loggable & Swift.Error {
    var log: (@autoclosure () -> String, LogLevel) -> Void { get set }
}

extension ErrorFiring where Self: LogErrorFiring {

    func fire(error: Self.Error, complete: ((Fire) -> Void)?) {
        log(error.message(for: .debug), .debug)
        complete?(.hit(error))
    }

}

final class LogErrorHandler: LogErrorFiring {

    var log: (@autoclosure () -> String, LogLevel) -> Void

    init(log: @escaping (@autoclosure () -> String, LogLevel) -> Void) {
        self.log = log
    }

}
