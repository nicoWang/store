//
//  DetailPresenter.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var item: ItemDetail? { get set }
    func popView()
    func share()
    func like()
}

class DetailPresenter: DetailPresenterProtocol {
    var item: ItemDetail?
    var wireframe: DetailWireframeProtocol?
    
    init(item: ItemDetail) {
        self.item = item
    }
    
    func popView() {
        wireframe?.popView()
    }
    
    func share() {
        print("share")
    }
    
    func like() {
        print("like")
    }
}
