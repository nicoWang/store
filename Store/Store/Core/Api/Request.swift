//
//  Request.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import Alamofire
import PromiseKit

class Request {
    static func request(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Promise<Data> {
        return Promise<Data> { seal in
            
            AF.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        seal.fulfill(data)
                    } else {
                        seal.reject(BaseError.undefined)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}
