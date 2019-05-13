//
//  Wiki.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Codextended

struct Wiki: Decodable {

    let title: String
    let desc: String
    let image: URL?

    init(from decoder: Decoder) throws {
        title = try decoder.decode("title")
        desc = try decoder.decode("desc")

        let imageUrlString = try decoder.decode("image") as String
        image = URL(string: imageUrlString.replacingOccurrences(of: "\n", with: ""))
    }

}
