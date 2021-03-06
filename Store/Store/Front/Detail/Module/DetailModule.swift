//
//  DetailModule.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import Foundation
import UIKit

protocol DetailModuleProtocol: AnyObject {
    func detailView(with item: ItemDetail, navigation: UINavigationController?) -> UIViewController
}

class DetailModule: DetailModuleProtocol {
    func detailView(with item: ItemDetail, navigation: UINavigationController?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(item: item)
        let wireframe = DetailWireframe(navigation: navigation)
        
        presenter.wireframe = wireframe
        view.presenter = presenter
        
        return view
    }
}
