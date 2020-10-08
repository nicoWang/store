//
//  DetailPresenter.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var item: ItemDetail? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    var item: ItemDetail?
    
    init(item: ItemDetail) {
        self.item = item
    }
}
