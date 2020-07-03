//
//  NetworkingState.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

/// The connections state for the client
public enum NetworkingState {
    /// code -1009
    case noNetworkConnection
    /// 200 status codes
    case connected
    /// 401 status code
    case unauthorized
    /// 500 status codes
    case serverError
}
