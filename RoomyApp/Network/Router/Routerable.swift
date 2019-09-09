//
//  RequestBuilder.swift
//  NetworkLayer
//
//  Created by Mac on 4/7/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import Foundation
import Alamofire

protocol Routerable: URLRequestConvertible,Requestable {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: String { get }
    
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    var headers : HTTPHeaders? { get }
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
}


extension Routerable {
    
    var mainURL: URL  {
        return URL(string: NetworkConstats.baseURL)!
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var encoding: ParameterEncoding{
        return URLEncoding.default
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        if let headers = headers{
            for (k, v) in headers{
                request.addValue(k, forHTTPHeaderField: v)
            }
        }
        return request
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
