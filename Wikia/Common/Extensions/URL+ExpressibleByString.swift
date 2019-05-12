//
//  URL+ExpressibleByString.swift
//  Wikia
//
//  Created by BOGU$ on 11/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }

}
