//
//  ListWireframe.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import UIKit

protocol ListWireframeProtocol: AnyObject {
    func pushToDetail(with item: ItemDetail)
}

class ListWireframe: ListWireframeProtocol {
    var navigation: UINavigationController?
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func pushToDetail(with item: ItemDetail) {
        let module = DetailModule()
        let view = module.detailView(with: item)
        navigation?.pushViewController(view, animated: true)
    }
}
