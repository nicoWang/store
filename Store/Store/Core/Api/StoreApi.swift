//
//  StoreApi.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import PromiseKit

class StoreAPI {
    func requestStore() -> Promise<Store> {
        return Promise<Store> { seal  in
            
            Request.request(url: Constants.mainUrl, method: .get, parameters: nil, headers: nil).done { response in
                
                guard let store = try? JSONDecoder().decode(Store.self, from: response) else { return seal.reject(BaseError.undefined) }
                
                seal.fulfill(store)
                }.catch { error in
                    seal.reject(BaseError.undefined)
            }
        }
    }
}
