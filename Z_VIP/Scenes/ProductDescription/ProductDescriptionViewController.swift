//
//  ProductDescriptionViewController.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/30/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductDescriptionDisplayLogic: class {
    func displayProductDescription(_ viewModel: ProductDescription.ViewModel)
}

class ProductDescriptionViewController: UIViewController, ProductDescriptionDisplayLogic {
    var interactor: ProductDescriptionBusinessLogic?
    var router: (NSObjectProtocol & ProductDescriptionRoutingLogic & ProductDescriptionDataPassing)?
    @IBOutlet weak var textView: UITextView!
    var viewModel = ProductDescription.ViewModel(attributedString: NSAttributedString())
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductDescriptionInteractor()
        let presenter = ProductDescriptionPresenter()
        let router = ProductDescriptionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchProductDescription()
    }
    
    func displayProductDescription(_ viewModel: ProductDescription.ViewModel) {
        self.textView.attributedText = viewModel.attributedString
    }
}
