//
//  CatalogViewController.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol CatalogDisplayLogic: class {
    func reloadProducts()
    func display(error message: Catalog.Error.ViewModel)
}

class CatalogViewController: UIViewController, CatalogDisplayLogic {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: CatalogBusinessLogic?
    var router: (NSObjectProtocol & CatalogRoutingLogic & CatalogDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Setup
    
    private func setup() {
        setupVIPComponents()
        setupCollectionView()
    }
    
    func setupVIPComponents() {
        let viewController = self
        let interactor = CatalogInteractor()
        let presenter = CatalogPresenter()
        let router = CatalogRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.fetchProducts()
    }
    
    func reloadProducts() {
        self.collectionView.reloadData()
    }
    
    func display(error message: Catalog.Error.ViewModel) {
        
    }
}

extension CatalogViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = interactor?.products[indexPath.item]
        cell.productImageView.kf.setImage(with: URL(string: product?.mainImageUrl ?? ""))
        cell.productNameLabel.text = product?.name
        return cell
    }
}

extension CatalogViewController: UICollectionViewDelegate {
    
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size =  Int((collectionView.frame.width) / 2)
        return CGSize(width: size, height: size)
    }
}
