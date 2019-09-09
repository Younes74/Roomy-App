//
//  ServerResponse.swift
//  Tourism
//
//  Created by mac  on 4/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct ServerResponse: Responsable{
    
    init(code: Int,data: Data?) {
        self.code = code
        self.data = data
    }
    
    var code: Int
    var data: Data?
    
    func isResponseValid() -> Bool {
        if (200..<400).contains(code){
            return true
        }else{
            return false
        }
    }
    
    func getError()->RequestError{
        switch code {
            case 400:
                return RequestError.BadParameter
            case 401:
                return RequestError.Authentication
            case 403:
                return RequestError.Authorization
            case 409:
                return RequestError.Bussiness
            default:
                return RequestError.ServerError
        }
    }
    
    
}
