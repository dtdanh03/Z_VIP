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
    
    class CatalogBusinessLogicSpy: CatalogBusinessLogic, ViewCatalogTracking {
        var fetchProductsCalled = false
        var trackOpenScreenCalled = false
        var trackProductTapCalled = false
        
        func fetchProducts() {
            fetchProductsCalled = true
        }
        
        func trackOpenScreen() {
            trackOpenScreenCalled = true
        }
        
        func trackProductTap(at index: Int) {
            trackProductTapCalled = true
        }
    }
    
    class CollectionViewSpy: UICollectionView {
        var isReloadDataCalled = false
        
        convenience init() {
            self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        }
        
        override func reloadData() {
            isReloadDataCalled = true
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
    
    func testShouldTrackOpenScreenWhenViewLoaded() {
        // Given
        let spy = CatalogBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.trackOpenScreenCalled, "viewDidLoad() should trigger tracking on open screen event")
    }
    
    func testDisplayProductShouldTriggerReloadData() {
        // Given
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let mockViewModel = Catalog.ViewModel(displayedProducts: [Product.catalogDisplayProduct(from: MockModels.product1)])
        
        // When
        sut.display(viewModel: mockViewModel)
        
        // Then
        XCTAssertTrue(collectionViewSpy.isReloadDataCalled, "display(viewModel:) should trigger collection view reload data")
    }
    
    func testNumberOfSectionInCollectionViewShouldBeOne() {
        //Given
        loadView()
        let collectionView = sut.collectionView
        
        //When
        let numberOfSection = sut.numberOfSections(in: collectionView!)
        
        //Then
        XCTAssertEqual(numberOfSection, 1, "Number of section in collection view should always be one")
    }
    
    func testNumberOfItemShouldEqualToNumberOfProductInViewModel() {
        //Given
        loadView()
        let collectionView = sut.collectionView
        let productsToDisplay = [Product.catalogDisplayProduct(from: MockModels.product1),
                                 Product.catalogDisplayProduct(from: MockModels.product2)]
        sut.viewModel = Catalog.ViewModel(displayedProducts: productsToDisplay)
        
        //When
        let numberOfItems = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
        
        //Then
        XCTAssertEqual(productsToDisplay.count, numberOfItems, "Number of item to display should be equal to number of item in view model")
    }
    
    func testCollectionViewCellShouldDisplayCorrectInformation() {
        //Given
        loadView()
        let collectionView = sut.collectionView
        let productsToDisplay = [Product.catalogDisplayProduct(from: MockModels.product1),
                                 Product.catalogDisplayProduct(from: MockModels.product2)]
        sut.viewModel = Catalog.ViewModel(displayedProducts: productsToDisplay)
        
        //When
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstCell = sut.collectionView(collectionView!, cellForItemAt: firstIndexPath) as! ProductCollectionViewCell
        
        let secondIndexPath = IndexPath(item: 1, section: 0)
        let secondCell = sut.collectionView(collectionView!, cellForItemAt: secondIndexPath) as! ProductCollectionViewCell
        
        //Then
        XCTAssertEqual(firstCell.productNameLabel.text, productsToDisplay[0].name, "Product cell should display the information in the view model")
        XCTAssertEqual(secondCell.productNameLabel.text, productsToDisplay[1].name, "Product cell should display the information in the view model")
    }
    
    func testTapOnCellShouldTriggerTrackingEvent() {
        //Given
        loadView()
        let spy = CatalogBusinessLogicSpy()
        sut.interactor = spy
        let collectionView = sut.collectionView
        let productsToDisplay = [Product.catalogDisplayProduct(from: MockModels.product1),
                                 Product.catalogDisplayProduct(from: MockModels.product2)]
        sut.viewModel = Catalog.ViewModel(displayedProducts: productsToDisplay)
        
        //When
        sut.collectionView(collectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        //Then
        XCTAssertTrue(spy.trackProductTapCalled, "Tap on cell should trigger tracking event")
    }
}
