//
//  NetworkError.swift
//  Tourism
//
//  Created by Mohamed El-Taweel on 6/28/19.
//  Copyright © 2019 Going. All rights reserved.
//

import Foundation

enum RequestError: Error{
    case NetworkConnectivity
    case BadResponse
    case Authentication
    case Authorization
    case BadParameter
    case Bussiness
    case ServerError
}
