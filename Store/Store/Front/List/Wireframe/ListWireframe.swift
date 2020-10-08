//
//  ListWireframe.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import UIKit

protocol ListWireframeProtocol: AnyObject {
    
}

class ListWireframe: ListWireframeProtocol {
    var navigation: UINavigationController?
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
}
