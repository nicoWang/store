//
//  ListModule.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import UIKit

protocol ListModuleProtocol: AnyObject {
    func listView() -> UINavigationController
}

final class ListModule: ListModuleProtocol {
    func listView() -> UINavigationController {
        let view = ListViewController()
        let navigation = UINavigationController(rootViewController: view)
        let api = StoreAPI()
        let interactor = ListInteractor(api: api)
        let presenter = ListPresenter(view: view)
        let wireframe = ListWireframe(navigation: navigation)
        
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        return navigation
    }
    
    
}
