//
//  CatalogViewControllerTests.swift
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

class CatalogViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CatalogViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupCatalogViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCatalogViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class CatalogBusinessLogicSpy: CatalogBusinessLogic {
        var fetchProductsCalled = false
        func fetchProducts() {
            fetchProductsCalled = true
        }

    }
    
    // MARK: Tests
    
    func testShouldFetchProductWhenViewLoaded() {
        // Given
        let spy = CatalogBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.fetchProductsCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testDisplaySomething() {
        // Given
        let mockProductViewModel = Catalog.ViewModel.DisplayedProduct(name: "mockProduct", mainImageUrl: "mockUrl")
        let mockViewModel = Catalog.ViewModel(displayedProducts: [mockProductViewModel])
        
        // When
        loadView()
        sut.display(viewModel: mockViewModel)
        
        // Then
        XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0), 1)
        XCTAssertEqual(sut.viewModel.displayedProducts.first?.name, "mockProduct")
        XCTAssertEqual(sut.viewModel.displayedProducts.first?.mainImageUrl, "mockUrl")
        
    }
}
