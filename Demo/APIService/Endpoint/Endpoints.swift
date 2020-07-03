//
//  Endpoints.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

extension Endpoint {

    static func fetchData(baseUrl: URL) -> Endpoint {
        return Endpoint(baseUrl: baseUrl, path: Path.fetchData, method: .get)
    }

}
