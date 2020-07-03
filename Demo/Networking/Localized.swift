//
//  Localized.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

struct Localized {

    static var dataReturnedNil = NSLocalizedString("dataReturnedNil", comment: "Either the response code or the header was missing in the response.")
    static var noInternetConnectionMessage = NSLocalizedString("noInternetConnectionMessage", comment: "There is no internet connection. Something wrong with the proxy server or the address is incorrect.")
    static var serverError = NSLocalizedString("serverError", comment: "An unexpected condition was encountered and no more specific message is suitable.")
    static var unauthorized = NSLocalizedString("unauthorized", comment: "The user does not have valid authentication credentials for the target resource.")


}
