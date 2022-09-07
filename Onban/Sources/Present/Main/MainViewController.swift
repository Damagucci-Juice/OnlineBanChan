//
//  MainViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    private let dataSource = MainDatasource()
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: .none, bundle: .none)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        setupLayout()
        setupBinding()
    }
    
    private func setupAttribute() {
        self.navigationItem.title = "Odering"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.collectionView.delegate = self.dataSource
        self.collectionView.dataSource = self.dataSource
        self.collectionView.register(MainCollectionViewCell.self,
                                     forCellWithReuseIdentifier: MainCollectionViewCell.reusableIdentifier)
        self.collectionView.register(
            MainCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainCollectionReusableView.reusableIdentifier
        )
    }
    
    private func setupLayout() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        
    }
}
