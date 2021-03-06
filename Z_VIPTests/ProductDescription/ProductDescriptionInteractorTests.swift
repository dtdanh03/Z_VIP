//
//  ProductDescriptionInteractorTests.swift
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

class ProductDescriptionInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ProductDescriptionInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupProductDescriptionInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductDescriptionInteractor() {
        sut = ProductDescriptionInteractor()
    }
    
    // MARK: Test doubles
    
    class ProductDescriptionPresentationLogicSpy: ProductDescriptionPresentationLogic {
        var presentProductDescription = false
        func present(productDescription: ProductDescription.Response) {
            presentProductDescription = true
        }
    }
    
    class ProductDescriptionWorkerSpy: ProductDescriptionProtocol {
        var fetchProductDescriptionCalled = false
        func fetchProductDescription(for product: Product, _ callback: @escaping (SingleResult<String>) -> Void) {
            fetchProductDescriptionCalled = true
            callback(SingleResult.success(""))
        }
    }
    
    // MARK: Tests
    
    func testFetchProductDescription() {
        // Given
        let presenterSpy = ProductDescriptionPresentationLogicSpy()
        sut.presenter = presenterSpy
        let workerSpy = ProductDescriptionWorkerSpy()
        sut.worker = workerSpy
        
        // When
        sut.fetchProductDescription()
        
        // Then
        XCTAssertTrue(presenterSpy.presentProductDescription, "fetchProductDescription() should ask presenter to present data")
        XCTAssertTrue(workerSpy.fetchProductDescriptionCalled, "fetchProductDescription() should ask worker to fetch product description")
    }
}
