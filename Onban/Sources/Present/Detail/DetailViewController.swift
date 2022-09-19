//
//  DetailViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/13.
//

import UIKit
import SnapKit
import RxRelay
import RxSwift
import RxAppState

class DetailViewController: UIViewController {
    typealias ViewModel = DetailViewModel
    
    private let imageManager = ImageManager.shared
    
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
    
    // TODO: - 뷰모델이 추가되면 대체될 것들임
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
        let view = OrderView(itemInformation: ItemTotalPriceAndAmount())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAttribute()
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let newViewModel = self.viewModel {
            self.bind(to: newViewModel)
        }
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
            make.bottom.equalTo(imageScrollView.frameLayoutGuide).inset(LayoutConstant.edgeSpacing)
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
        orderView.delegate = self
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

extension DetailViewController: PaymentRequestResponder {
    func requestPayment(_ itemInformation: ItemTotalPriceAndAmount) {
        print("detailVC 에서 \(itemInformation.totalPirce)를 확인하였습니다.")
        viewModel?.action.requestPayment.accept(())
    }
}

extension DetailViewController: View {
    func bind(to viewModel: DetailViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.loadDetail)
            .disposed(by: disposeBag)
        
        viewModel.state.readyViewModel
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { [unowned self] in
                self.informationView.setupInformations(viewModel)
                self.orderView.updateItemInformation(viewModel.reducedPrice)
            })
            .disposed(by: disposeBag)
    }
}
