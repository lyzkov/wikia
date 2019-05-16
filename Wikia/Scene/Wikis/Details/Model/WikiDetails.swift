//
//  WikiDetails.swift
//  Wikia
//
//  Created by BOGU$ on 14/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

struct WikiDetails {

    let title: String
    let description: String
    let imageURL: URL?
    let websiteURL: URL?
    let stats: [WikiStats]
    
}

extension WikiDetails {

    init(from wiki: Wiki) {
        title = wiki.title
        description = wiki.desc
        imageURL = wiki.image
        websiteURL = wiki.url
        stats = .init(from: wiki.stats)
    }

}
