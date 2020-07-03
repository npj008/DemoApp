//
//  TrialTaskAPIService.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

public enum TrialTaskAPIServiceResult<T> {
    case success(_: T)
    case failure(_: TrialTaskAPIServiceError)
}

struct APIService {

    static let baseUrl = URL(string: "https://stark-spire-93433.herokuapp.com")!

    static var shared = TrialTaskAPIService.init(baseUrl: baseUrl)
}

public struct TrialTaskAPIService {

    let baseUrl: URL

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func fetchData(completion: @escaping (_: TrialTaskAPIServiceResult<DataResponse>) -> Void) {
        let endpoint = Endpoint.fetchData(baseUrl: baseUrl)
        let request = endpoint.createRequest()
        let networking = Networking<DataResponse>()
        networking.sendRequest(request) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(.network(error)))
                break
            }
        }
    }
}
