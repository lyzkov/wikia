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
    let imageURL: URL?
}

extension WikiOverview {

    init(from wiki: Wiki) {
        title = wiki.title
        imageURL = wiki.image
    }

}
