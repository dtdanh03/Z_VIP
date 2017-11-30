//
//  CatalogInteractorTests.swift
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

class CatalogInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CatalogInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCatalogInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCatalogInteractor() {
        sut = CatalogInteractor()
    }
    
    // MARK: Test doubles
    
    class CatalogPresentationLogicSpy: CatalogPresentationLogic {
        var presentProductsCalled = false
        var presentErrorCalled = false
        func present(products: Catalog.Response) {
            presentProductsCalled = true
        }
        
        func present(error: Z_VIP.Error) {
            presentErrorCalled = true
        }
    }
    
    // MARK: Tests
    
    func testFetchProducts() {
        // Given
        let spy = CatalogPresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.fetchProducts()
        
        // Then
        XCTAssertTrue(spy.presentProductsCalled, "fetchProducts() should ask the presenter to format the result")
    }
}
