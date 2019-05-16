//
//  Wiki.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Codextended

struct Wiki: Decodable {

    struct Stats: Decodable {
        let users: Int
        let articles: Int
        let pages: Int
        let admins: Int
        let activeUsers: Int
        let edits: Int
        let videos: Int
        let images: Int
    }

    let title: String
    let desc: String
    let image: URL?
    let url: URL?
    let stats: Stats

    init(from decoder: Decoder) throws {
        title = try decoder.decode("title")
        desc = try decoder.decode("desc")

        url = try decoder.decode("url")

        let imageUrlString = try decoder.decode("image") as String
        image = URL(string: imageUrlString.replacingOccurrences(of: "\n", with: ""))
        
        stats = try decoder.decode("stats")
    }

}
