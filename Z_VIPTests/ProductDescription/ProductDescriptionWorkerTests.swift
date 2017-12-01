//
//  ProductDescriptionWorkerTests.swift
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

class ProductDescriptionWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ProductDescriptionWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupProductDescriptionWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductDescriptionWorker() {
        sut = ProductDescriptionWorker(productService: MockProductService())
    }
    
    // MARK: Test doubles
    
    
    // MARK: Tests
    
    func testLoadProductDescriptionSuccess() {
        // Given
        let expect = expectation(description: "ProductDescriptionWorker should load product description successfully")
        var resultDescription = ""
        // When
        sut.fetchProductDescription(for: MockModels.product1) { (result) in
            switch result {
            case .success(let productDescription):
                resultDescription = productDescription
                expect.fulfill()
            case .failure(_):
                break
            }
        }
        
        // Then
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                print(error)
            }
        }
        XCTAssertEqual(resultDescription, MockProductService.mockProductDescription, "Product description should match the mocks result")
    }
    
    func testLoadProductDescriptionFail() {
        //Given
        let expect = expectation(description: "ProductDescriptionWorker should return failure if service cannot load")
        sut.productService = MockProductService(shouldReturnFailure: true)
        // When
        sut.fetchProductDescription(for: MockModels.product1) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                expect.fulfill()
            }
        }
        
        // Then
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}
