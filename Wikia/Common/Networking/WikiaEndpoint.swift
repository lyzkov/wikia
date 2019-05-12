//
//  WikiaEndpoint.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

protocol WikiaEndpoint: Endpoint {
}

extension WikiaEndpoint {

    static var api: RestAPI.Type {
        return WikiaAPI.self
    }

}
