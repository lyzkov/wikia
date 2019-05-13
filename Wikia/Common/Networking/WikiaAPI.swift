//
//  WikiaAPI.swift
//  Wikia
//
//  Created by BOGU$ on 11/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Alamofire

struct WikiaAPI: RestAPI {

    static var base = APIConfiguration(url: "https://www.wikia.com/api/v1")

    enum Wikis: URLRequestConvertible {
        case list(limit: UInt, batch: UInt)

        func asURLRequest() throws -> URLRequest {
            switch self {
            case let .list(limit, batch):
                return try List(limit: limit, batch: batch).asURLRequest()
            }
        }

    }

    struct List: WikiaEndpoint, GetEndpoint {
        typealias Result = Batch<Wiki>

        let path: String = "/Wikis/List"

        let limit: UInt

        let batch: UInt

        var parameters: Parameters {
            return ["limit": limit, "batch": batch, "expand": 1]
        }

    }

}
