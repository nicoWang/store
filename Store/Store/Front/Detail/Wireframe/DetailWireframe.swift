//
//  DetailWireframe.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import Foundation
import UIKit

protocol DetailWireframeProtocol: AnyObject {
    func popView()
}

class DetailWireframe: DetailWireframeProtocol {
    var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func popView() {
        navigation?.popViewController(animated: true)
    }
}
