//
//  ProductDescriptionViewControllerTests.swift
//  Z_VIP
//
//  Created by Danh Dang on 12/1/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Z_VIP
import XCTest

class ProductDescriptionViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ProductDescriptionViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupProductDescriptionViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductDescriptionViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ProductDescriptionBusinessLogicSpy: ProductDescriptionBusinessLogic {
        
        var fetchProductDescriptionCalled = false
        func fetchProductDescription() {
            fetchProductDescriptionCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldFetchProductDescriptionWhenViewIsLoaded() {
        // Given
        let spy = ProductDescriptionBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.fetchProductDescriptionCalled, "viewDidLoad() should ask the interactor fetch product description")
    }
    
    func testDisplayProductDescription() {
        // Given
        let viewModel = ProductDescription.ViewModel(attributedString: NSAttributedString(string: MockProductService.mockProductDescription, attributes: nil))
        
        // When
        loadView()
        sut.displayProductDescription(viewModel)
        
        // Then
        XCTAssertEqual(sut.textView.text, MockProductService.mockProductDescription)
    }
}