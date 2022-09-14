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
    //MARK: - 나중에 지울 것임
    private let informationView: InformationView = {
        let view = InformationView(frame: .zero)
        return view
    }()
    
    private let subview2: OrderView = {
        let view = OrderView(frame: .zero)
        return view
    }()
    
    private let subview3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    //MARK: - 여기까지
    
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
        let subViews = [informationView, subview2, subview3]
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubViews(subViews)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subViews.forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(400)
                $0.width.equalTo(self.view.safeAreaLayoutGuide)
            }
        }
        
    }
    
    private func setAttribute() {
        
    }
    
    func bind(to viewModel: DetailViewModel) {
        // TODO: - 나중에 뷰모델 만들어지면 바인딩 할 것들.
    }
}
