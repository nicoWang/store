//
//  ListPresenter.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation
import UIKit
import PromiseKit

protocol ListPresenterProtocol: AnyObject {
    func bind()
    func numberOfRows(for section: Int) -> Int
    func numberOfSections() -> Int
    func reload()
    func didSelectItem(at index: IndexPath)
    func item(at index: IndexPath) -> Item? 
}

final class ListPresenter: ListPresenterProtocol {
    
    private let view: ListView
    var interactor: ListInteractorProtocol?
    var wireframe: ListWireframeProtocol?
    var store: Store?

    init(view: ListView) {
        self.view = view
    }
    
    func bind() {
        getStore()
    }
    
    func numberOfRows(for section: Int) -> Int {
        guard let store = self.store, let items = store.sections?[section].items else { return 0 }
        return items.count
    }
    
    func reload() {
        
    }
    
    func didSelectItem(at index: IndexPath) {
        guard let item = item(at: index), let path = item.detailURL else { return }
        print(path)
    }
    
    func numberOfSections() -> Int {
        return store?.sections?.count ?? 0
    }
    
    func item(at index: IndexPath) -> Item? {
        return store?.sections?[index.section].items?[index.row]
    }
}

// MARK: - Private
private extension ListPresenter {
    func getStore() {
        interactor?.requestStore().done { [weak self] store in
            self?.store = store
            self?.view.reload()
        }.ensure {
            print("hideLoader")
        }.catch { error in
            print(error)
        }
    }
}
