//
//  WikiStats.swift
//  Wikia
//
//  Created by BOGU$ on 15/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

enum WikiStats {
    case users(Int), articles(Int), pages(Int), admins(Int), activeUsers(Int), edits(Int), videos(Int),
        images(Int), comments(Int)
}

extension WikiStats {

    var tag: Int {
        switch self {
        case .users: return 0
        case .pages: return 1
        case .admins: return 2
        case .edits: return 3
        case .activeUsers: return 4
        case .videos: return 5
        case .images: return 6
        case .articles: return 7
        case .comments: return 8
        }
    }

    var description: String {
        switch self {
        case .users(let value): return "Users: \(value.abbreviation)"
        case .pages(let value): return "Pages: \(value.abbreviation)"
        case .admins(let value): return "Admins: \(value.abbreviation)"
        case .edits(let value): return "Edits: \(value.abbreviation)"
        case .activeUsers(let value): return "Active users: \(value.abbreviation)"
        case .videos(let value): return "Videos: \(value.abbreviation)"
        case .images(let value): return "Images: \(value.abbreviation)"
        case .articles(let value): return "Articles: \(value.abbreviation)"
        case .comments(let value): return "Comments: \(value.abbreviation)"
        }
    }

}

extension Array where Element == WikiStats {

    init(from wikiStats: Wiki.Stats) {
        self = [
            .users(wikiStats.users),
            .pages(wikiStats.pages),
            .admins(wikiStats.admins),
            .edits(wikiStats.edits),
            .activeUsers(wikiStats.activeUsers),
            .videos(wikiStats.videos),
            .articles(wikiStats.articles),
            .images(wikiStats.images),
        ]
    }

}

fileprivate extension Int {

    private static let suffix = ["", "K", "M", "B", "T", "P", "E"]

    var abbreviation: String {
        var index = 0
        var value = self
        while((value / 1000) >= 1){
            value = value / 1000
            index += 1
        }

        return "\(value)\(Int.suffix[index])"
    }

}
