//
//  Constants.swift
//  NetworkLayer
//
//  Created by mac  on 4/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

enum NetworkConstats{
    
    static private let enviroment = NetworkEnviroment.production
    
    static private let developmentBaseURL = ""
    static private let stagingBaseURL = ""
    static private let productionBaseURL = "https://www.thesportsdb.com/api/v1/json/1/"
    
        
    static var baseURL: String {
        get {
            switch enviroment{
                case .development:
                    return developmentBaseURL
                case .staging:
                    return stagingBaseURL
                case .production:
                    return productionBaseURL
            }
        }
    }
}
