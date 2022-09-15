//
//  DetailViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/13.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, View {
    typealias ViewModel = DetailViewModel
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private let informationView: InformationView = {
        let view = InformationView(frame: .zero)
        return view
    }()
    
    private let orderView: OrderView = {
        let view = OrderView(frame: .zero)
        return view
    }()
    
    init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAttribute()
    }
    
    private func setLayout() {
        let subViews = [informationView, orderView]
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubViews(subViews)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        informationView.snp.makeConstraints { make in
            make.height.equalTo(293)
            make.width.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        orderView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setAttribute() {
        setupNavigation()
        self.view.backgroundColor = UIColor.white
    }
    
    func bind(to viewModel: DetailViewModel) {
        // TODO: - 나중에 뷰모델 만들어지면 바인딩 할 것들.
    }
    
    private func setupNavigation() {
        self.navigationItem.title = self.informationView.title.text
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
}
