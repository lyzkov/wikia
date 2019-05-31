//
//  Loggable.swift
//  Wikia
//
//  Created by BOGU$ on 31/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

protocol Loggable {
    func message(for logLevel: LogLevel) -> String

}

enum LogLevel: Int {
    case verbose, debug, info, warn, error
}
