//
//  CALayer+IB.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

extension CALayer {

    open override func setValue(_ value: Any?, forKey key: String) {
        if key == "borderColor", let color = value as? UIColor {
            return super.setValue(color.cgColor, forKey: key)
        }

        super.setValue(value, forKey: key)
    }

}
