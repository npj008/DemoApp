//
//  NetworkingError.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

/// Representation of the type of networking error.
public enum NetworkingError: Error {
    /// There was no data retruned
    case dataReturnedNil(String?)
    /// Remote server error
    case serverError
    /// Provided auth was not valid
    case unauthorized
    /// Internet is not online
    case noInternetConnection
    /// Status code not expected
    case invalidStatusCode(Int)
    /// Could not parse json data
    case jsonParsing(String)
    /// Another error occurred
    case custom(String)
    /// Access is not allowed
    case forbidden
    
    /// Provides interface to check and return `NetworkError` type as per status code.
    /// - Parameter code: the http status code recieved from server.
    static func error(forStatusCode code: Int) -> NetworkingError? {
        switch code {
        case 200...299:
            return nil
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 500...599:
            return .serverError
        case -1009:
            return .noInternetConnection
        default:
            return .invalidStatusCode(code)
        }
    }
}

extension NetworkingError: LocalizedError {
    /// :nodoc:
    public var localizedDescription: String? {
        switch self {
        case .custom(let message):
            return message
        case .dataReturnedNil(let message):
            return message ?? Localized.dataReturnedNil
        case .serverError:
            return  Localized.serverError
        case .unauthorized:
            return Localized.unauthorized
        case .noInternetConnection:
            return Localized.noInternetConnectionMessage
        case .invalidStatusCode(let code):
            return "Invalid Status Code : \(code)"
        case .forbidden:
            return "403 Forbidden."
        case .jsonParsing(let message):
            return "Unable to parse JSON response: \(message)"
        }
    }
}

extension NetworkingError: Equatable {
    /// Check if 2 `NetworkingError`s are the same
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsMessage), .custom(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.dataReturnedNil, .dataReturnedNil):
            return true
        case (.serverError, .serverError):
            return true
        case (.unauthorized, .unauthorized):
            return true
        case (.noInternetConnection, .noInternetConnection):
            return true
        case (.invalidStatusCode(let lhsCode), .invalidStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        case (.forbidden, .forbidden):
            return true
        default:
            return false
        }
        
    }
}

extension Notification.Name {

    static let networkingUnauthenticatedErrorNotification = Notification.Name("ellen-NetworkingUnauthenticatedErrorNotification")

}

//extension Client {
//
//    func beginObservingUnauthenticatedErrors() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveUnauthenticatedError),
//                                               name: .networkingUnauthenticatedErrorNotification,
//                                               object: nil)
//    }
//
//    func endObservingUnauthenticatedErrors() {
//        NotificationCenter.default.removeObserver(self, name: .networkingUnauthenticatedErrorNotification, object: nil)
//    }
//
//    @objc func didReceiveUnauthenticatedError() {
//        tokenUpdateRequestHandler?({ [weak self] token in
//            guard let token = token else { return }
//            self?.setPrincipal(token: token)
//        })
//    }
//
//    /// Manually trigger the client to reresh its messaging token
//    public func askForMessagingToken() {
//        didReceiveUnauthenticatedError()
//    }
//
//}
