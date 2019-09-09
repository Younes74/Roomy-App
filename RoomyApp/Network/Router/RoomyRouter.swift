//
//  AuthenticationRouter.swift
//  RoomyApp
//
//  Created by MAC on 9/1/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import Foundation
import Alamofire

enum RoomyRouter: Routerable {
    
    case login(email: String,password: String)
    case register(name:String,email:String,password: String)
    case getRooms
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .register:
            return "signup"
        case .getRooms:
            return "rooms"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let email,let password):
            return ["email":email,"password":password]
        case .register(let name,let email,let password):
            return ["email":email,"password":password,"name":name]
        case .getRooms:
            return nil
            
        }
    }
    
    var headers : HTTPHeaders? {
        switch self {
        case .login:
            return nil
        case .register:
            return nil
        case .getRooms:
            let token = UserDefaults.standard.string(forKey: "userToken") 
            let headers = ["Authorization": token]
            return headers as? HTTPHeaders
        }
    }
    // MARK: - Methods
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .getRooms:
            return .get
        }
    }
    
    var mainURL: URL  {
        return URL(string: "https://roomy-application.herokuapp.com/")!
    }
    
    
}
