//
//  Requestable.swift
//  
//
//  Created by mac  on 4/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol Requestable {
    
    func requestEndPoint(files: [File]?,onRequestSuccess: ((Responsable)->())?, onRequestFailure: ((RequestError)->())?)->Single<Responsable>

    func requestEndPointWithoutData( onRequestSuccess: ((Responsable)->())?, onRequestFailure: ((RequestError)->())?)->Single<Responsable>

    func requestEndPointWithData(data: [File],onRequestSuccess: ((Responsable)->())?, onRequestFailure: ((RequestError)->())?)->Single<Responsable>

}

extension Requestable where Self: Routerable{
    
    @discardableResult
    func requestEndPoint(files: [File]? = nil,onRequestSuccess: ((Responsable)->())? = nil, onRequestFailure: ((RequestError)->())? = nil)->Single<Responsable>{
        if let files = files{
            let observable = requestEndPointWithData(data: files, onRequestSuccess: onRequestSuccess, onRequestFailure: onRequestFailure)
            return observable
        }else{
            let observable = requestEndPointWithoutData(onRequestSuccess: onRequestSuccess, onRequestFailure: onRequestFailure)
            return observable
        }
        
    }
    
    @discardableResult
    func requestEndPointWithoutData( onRequestSuccess: ((Responsable)->())?, onRequestFailure: ((RequestError)->())?)->Single<Responsable>{
        let observable = Single<Responsable>.create{ single in
            Alamofire.request(self.requestURL.absoluteString,method: self.method,parameters: self.parameters,encoding: self.encoding,headers: self.headers).responseData { response in
                switch response.result {
                case .success(let value):
                    // response String .
                    var _ = String(decoding: value, as: UTF8.self)
                    let statusCode = response.response?.statusCode ?? 500
                    let serverResponse = ServerResponse(code: statusCode, data: value)
                    let responseStatus = serverResponse.isResponseValid()
                    if responseStatus{
                        if let onRequestSuccess = onRequestSuccess{
                            onRequestSuccess(serverResponse)
                        }
                        single(.success(serverResponse))
                    }else{
                        let error = serverResponse.getError()
                        if let onRequestFailure = onRequestFailure{
                            onRequestFailure(error)
                        }
                        single(.error(error))
                    }
                case .failure(let error):
                    
                    if let err = error as? URLError, err.code == .notConnectedToInternet {
                        if let onRequestFailure = onRequestFailure{
                            onRequestFailure(RequestError.NetworkConnectivity)
                        }
                        single(.error(RequestError.NetworkConnectivity))
                    } else {
                        if let onRequestFailure = onRequestFailure{
                            onRequestFailure(RequestError.ServerError)
                        }
                        single(.error(RequestError.ServerError))
                    }

                }
            }
            return Disposables.create()
        }
        return observable
    }
    
    @discardableResult
    func requestEndPointWithData(data: [File],onRequestSuccess: ((Responsable)->())?, onRequestFailure: ((RequestError)->())?)->Single<Responsable>{
        let observable = Single<Responsable>.create{ single in
            
            Alamofire.upload(multipartFormData: {
                multipartFormData in
                if let requestParameters = self.parameters{
                    for (key,value) in requestParameters {
                        let valueAsString = value as! String
                        multipartFormData.append(valueAsString.data(using: .utf8)!, withName: key)
                    }
                }
                
                for file in data{
                    multipartFormData.append(file.fileURL, withName: file.fileName)
                }
            }, to: self.requestURL.absoluteString,method: self.method, headers: self.headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload,_,_):
                    upload.responseJSON { response in
                        let statusCode = response.response?.statusCode ?? 500
                        let serverResponse = ServerResponse(code: statusCode, data: response.data)
                        let responseStatus = serverResponse.isResponseValid()
                        if responseStatus{
                            if let onRequestSuccess = onRequestSuccess{
                                onRequestSuccess(serverResponse)
                            }
                            single(.success(serverResponse))
                        }else{
                            let error = serverResponse.getError()
                            if let onRequestFailure = onRequestFailure{
                                onRequestFailure(error)
                            }
                            single(.error(error))
                        }
                        
                    }
                case .failure(let error):
                    if let err = error as? URLError, err.code == .notConnectedToInternet {
                        if let onRequestFailure = onRequestFailure{
                            onRequestFailure(RequestError.NetworkConnectivity)
                        }
                        single(.error(RequestError.NetworkConnectivity))
                    } else {
                        if let onRequestFailure = onRequestFailure{
                            onRequestFailure(RequestError.ServerError)
                        }
                        single(.error(RequestError.ServerError))
                    }
                }
            })
            return Disposables.create()
        }
        return observable


    }
    
}
