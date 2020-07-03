//
//  NetworkingResult.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

public enum NetworkingResult<T> {
    case success(T)
    case failure(NetworkingError)
}
