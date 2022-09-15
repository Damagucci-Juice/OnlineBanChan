//
//  MainViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    private let dataSource: MainDatasource
    private let disposeBag = DisposeBag()
    
    init(viewModel: MainViewModel) {
        self.dataSource = MainDatasource(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.bind(self.dataSource)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        setupLayout()
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
    
    private func bind(_ dataSource: MainDatasource) {
        dataSource.state.reloadSectionData
            .map { IndexSet(integer: $0) }
            .observe(on: MainScheduler.asyncInstance)
            .do { print($0) }
            .bind(onNext: collectionView.reloadSections)
            .disposed(by: disposeBag)
    }
}
