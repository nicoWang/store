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
}
