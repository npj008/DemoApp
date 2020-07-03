//
//  TrialTaskAPIServiceError.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

public enum TrialTaskAPIServiceError: Error {

    case network(_: NetworkingError)
    
    public var localizedDescription: String {
        switch self {
        case .network(let error):
            return error.localizedDescription
        }
    }

}
