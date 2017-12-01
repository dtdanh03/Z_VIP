//
//  ProductDetailViewControllerTests.swift
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

class ProductDetailViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ProductDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupProductDetailViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductDetailViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ProductDetailBusinessLogicSpy: ProductDetailBusinessLogic {
        var fetchImageListCalled = false
        
        func fetchImageList(for request: ProductDetail.Request) {
            fetchImageListCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldFetchImageListWhenViewLoaded() {
        // Given
        let spy = ProductDetailBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.fetchImageListCalled, "viewDidLoad() should ask the interactor to fetch image list")
    }
    
    func testDisplaySomething() {
        // Given
        let viewModel = ProductDetail.ViewModel(product: ProductDetail.ViewModel.DisplayProduct(), imageList: [])
        
        // When
        loadView()
        sut.display(productDetail: viewModel)
        
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}