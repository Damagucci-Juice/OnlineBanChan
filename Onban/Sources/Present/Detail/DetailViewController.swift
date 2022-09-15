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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentMode = .scaleAspectFill
        return scrollView
    }()
    
    //TODO: - 뷰모델이 추가되면 대체될 것들임
    private let images: [UIImage?] = [
        UIImage(named: "meet.jpeg"),
        UIImage(named: "me.jpeg"),
        UIImage(named: "mockImage.png")
    ]
    
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .minimal
        pageControl.currentPageIndicatorTintColor = UIColor.primary2
        pageControl.pageIndicatorTintColor = UIColor.white
        return pageControl
    }()
    
    @objc private func pageControlDidChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        imageScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width,
                                                 y: 0), animated: true)
    }
    
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        let subViews = [imageScrollView, informationView, orderView]
        containerStackView.addArrangedSubViews(subViews)
        
        imageScrollView.addSubview(pageControl)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageScrollView.snp.makeConstraints { make in
            make.width.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(imageScrollView.snp.width)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(imageScrollView.frameLayoutGuide)
            make.bottom.equalTo(imageScrollView.frameLayoutGuide).inset(16)
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
        setupImageScrollView()
        setupPageControl()
        self.view.backgroundColor = UIColor.white
    }
    
    func bind(to viewModel: DetailViewModel) {
        // TODO: - 나중에 뷰모델 만들어지면 바인딩 할 것들.
    }
    
    private func setupNavigation() {
        self.navigationItem.title = self.informationView.title.text
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func setupImageScrollView() {
        imageScrollView.delegate = self
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.contentSize = CGSize(
            width: view.frame.size.width * CGFloat(images.count),
            height: imageScrollView.frame.size.height
        )
        imageScrollView.isPagingEnabled = true
        
        for x in 0..<images.count {
            let page = UIImageView(frame: CGRect(
                x: CGFloat(x) * view.frame.size.width,
                y: 0,
                width: view.frame.size.width,
                height: view.frame.size.width))
            page.image = images[x]
            imageScrollView.addSubview(page)
            
            //MARK: - 수정 필요, 실제 데이터를 보면서 해봐야하는 부분일듯
            let detailImage = UIImageView()
            detailImage.image = images[x]
            detailImage.contentMode = .scaleAspectFill
            containerStackView.addArrangedSubview(detailImage)
        }
        
        
    }
    
    private func setupPageControl() {
        imageScrollView.bringSubviewToFront(pageControl)
        pageControl.numberOfPages = images.count
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChanged(_:)),
                              for: .valueChanged)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(
            Float(imageScrollView.contentOffset.x) / Float(imageScrollView.frame.size.width)
        ))
    }
}
