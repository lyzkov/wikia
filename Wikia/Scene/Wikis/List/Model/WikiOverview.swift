//
//  WikiOverview.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

struct WikiOverview {
    let title: String
    let image: UIImage?
}

extension WikiOverview {

    init(from wiki: Wiki) {
        title = wiki.title
        image = nil
    }

}
