//
//  StoreTests.swift
//  StoreTests
//
//  Created by Nicolas Wang on 07/10/2020.
//

import XCTest
@testable import Store
import PromiseKit

class StoreTests: XCTestCase {

    private typealias SUT = (presenter: ListPresenterProtocol, interactor: ListInteractorProtocol, wireframe: MockWireframe)
    private var sut: SUT?

    override func setUp() {
        super.setUp()
        sut = getSUT()
    }

}

// MARK: - Tests
extension StoreTests {
    func testAPI() {
        let interactor = sut?.interactor
        interactor?.requestStore().done { store in
            XCTAssertNotNil(store.title)
            XCTAssertNotNil(store.sections)
            XCTAssertEqual(store.sections?.count, 2)
            if let section = store.sections?[0] {
                XCTAssertNotNil(section.title)
                XCTAssertNotNil(section.items)
                XCTAssertEqual(section.items?.count, 4)

                if let item = section.items?[0] {
                    XCTAssertNotNil(item.detailURL)
                    XCTAssertNotNil(item.imageURL)
                    XCTAssertNotNil(item.title)
                    XCTAssertNotNil(item.brand)
                    XCTAssertNotNil(item.tags)
                    XCTAssertNotNil(item.favoriteCount)
                }
            }
        }
    }
}

// MARK: - Setup
extension StoreTests {
    private func getSUT() -> SUT {
        let api = MockApi()
        let interactor = ListInteractor(api: api)
        let presenter = ListPresenter(view: MockView())
        let wireframe = MockWireframe()
        
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        return (presenter, interactor, wireframe)
    }
    
    private class MockApi: StoreApiProtocol {
        
        func requestStore() -> Promise<Store> {
            return Promise<Store> { seal in
                guard let response = getData(of: "store"), let store = try? JSONDecoder().decode(Store.self, from: response) else { return seal.reject(BaseError.undefined) }

                seal.fulfill(store)
            }
        }
        
        func requestDetail(with url: String) -> Promise<ItemDetail> {
            return Promise<ItemDetail> { seal in
                guard let response = getData(of: "detail"), let item = try? JSONDecoder().decode(ItemDetail.self, from: response) else { return seal.reject(BaseError.undefined) }
                seal.fulfill(item)
            }
        }
        
        private func getData(of file: String) -> Data? {
            let data = readDictionaryJson(fileName: file)
            return data
        }
        
        func readDictionaryJson(fileName: String) -> Data? {
            do {
                if let file = Bundle.main.path(forResource: fileName, ofType: "json") {
                    let data = try Data(contentsOf: URL(fileURLWithPath: file))
                    return data
                }
            } catch {
                print(error.localizedDescription)
            }
            return nil
        }
    }
    
    private class MockWireframe: ListWireframeProtocol {
        var didPush = false
        func pushToDetail(with item: ItemDetail) {
            didPush = true
        }
    }
    
    private class MockView: ListView {
        var didReload = false
        func reload() {
            didReload = true
        }
    }
}

