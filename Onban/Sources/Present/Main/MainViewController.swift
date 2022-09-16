//
//  MainViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import SnapKit
import RxSwift
import RxAppState

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    private let dataSource = MainDatasource()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
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
}

extension MainViewController: View {
    func bind(to viewModel: MainViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.items
            .bind(onNext: dataSource.updateItems)
            .disposed(by: disposeBag)
        
        dataSource.state.readySection
            .map { IndexSet(integer: $0) }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: self.collectionView.reloadSections)
            .disposed(by: disposeBag)
    }
}
