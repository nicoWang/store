//
//  StoreApi.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import PromiseKit

protocol StoreApiProtocol: AnyObject {
    func requestStore() -> Promise<Store>
    func requestDetail(with url: String) -> Promise<ItemDetail>
}

class StoreAPI: StoreApiProtocol {
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
    
    func requestDetail(with url: String) -> Promise<ItemDetail> {
        return Promise<ItemDetail> { seal in
            Request.request(url: url, method: .get, parameters: nil, headers: nil).done { response in
                guard let item = try? JSONDecoder().decode(ItemDetail.self, from: response) else { return seal.reject(BaseError.undefined) }
                seal.fulfill(item)
                }.catch { error in
                    seal.reject(BaseError.undefined)
            }
        }
    }
}
