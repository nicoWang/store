//
//  ListInteractor.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import PromiseKit

protocol ListInteractorProtocol: AnyObject {
    func requestStore() -> Promise<Store>
    func requestDetail(with url: String) -> Promise<ItemDetail>
}

final class ListInteractor: ListInteractorProtocol {
    var presenter: ListPresenterProtocol?
    private let api: StoreApiProtocol
    
    init(api: StoreApiProtocol) {
        self.api = api
    }
    
    func requestStore() -> Promise<Store> {
        return api.requestStore()
    }
    
    func requestDetail(with url: String) -> Promise<ItemDetail> {
        return api.requestDetail(with: url)
    }
}
