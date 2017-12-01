//
//  CatalogPresenterTests.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/30/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Z_VIP
import XCTest

class CatalogPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CatalogPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCatalogPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCatalogPresenter() {
        sut = CatalogPresenter()
    }
    
    // MARK: Test doubles
    
    class CatalogDisplayLogicSpy: CatalogDisplayLogic {
        var displayViewModelCalled = false
        var displayErrorCalled = false
        var catalogViewModel: Catalog.ViewModel!
        func display(viewModel: Catalog.ViewModel) {
            displayViewModelCalled = true
            catalogViewModel = viewModel
        }
        
        func display(error: Z_VIP.Error) {
            displayErrorCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentViewModel() {
        // Given
        let spy = CatalogDisplayLogicSpy()
        sut.viewController = spy
        let response = Catalog.Response(products: [MockModels.product1, MockModels.product2])
        let viewModelToDisplay = [Product.catalogDisplayProduct(from: MockModels.product1),
                                  Product.catalogDisplayProduct(from: MockModels.product2)]
        // When
        sut.present(products: response)
        
        // Then
        XCTAssertTrue(spy.displayViewModelCalled, "present(products:) should ask the view controller to display the result")
        XCTAssertEqual(viewModelToDisplay.count, spy.catalogViewModel.displayedProducts.count, "present(product:) should ask display logic to display the same amount of product in the response")
        spy.catalogViewModel.displayedProducts.enumerated().forEach { (index, product) in
            XCTAssertEqual(product.name, viewModelToDisplay[index].name, "Product name in response and view model should be the same")
            XCTAssertEqual(product.mainImageUrl, viewModelToDisplay[index].mainImageUrl, "Product image url in response and view model should be the same")
        }
    }
}
