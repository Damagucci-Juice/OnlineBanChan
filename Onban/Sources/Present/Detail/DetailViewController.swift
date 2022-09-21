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
    
    var isBeforePresented: Bool = false
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentMode = .scaleAspectFill
        return scrollView
    }()
    
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private let exampleImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
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
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isBeforePresented,
           let newViewModel = self.viewModel {
            self.bind(to: newViewModel)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isBeforePresented = true
    }
    
    private func setLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        let subViews = [imageScrollView, informationView, orderView, exampleImageStackView]
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
        self.view.backgroundColor = UIColor.white
        orderView.delegate = self
    }
    
    private func setupNavigation() {
        navigationItem.title = self.viewModel?.title
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "뒤로")
    }
    
    private func setupImageScrollView() {
        imageScrollView.delegate = self
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.contentSize = CGSize(
            width: view.frame.size.width * CGFloat(2),
            height: imageScrollView.frame.size.height
        )
        imageScrollView.isPagingEnabled = true
    }
    
    private func setupPageControl(_ pages: Int) {
        imageScrollView.bringSubviewToFront(pageControl)
        pageControl.numberOfPages = pages
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
                Task {
                    await self.updateBannerImages(viewModel)
                    await self.updateExampleImages(viewModel)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    
    private func updateBannerImages(_ viewModel: DetailViewModel) async {
        let bannerURLs = viewModel.bannerImages

        let banners = await withTaskGroup(of: UIImage?.self, returning: [UIImage?].self) { taskGroup in
            for bannerURL in bannerURLs {
                taskGroup.addTask { await self.imageManager.loadImage(url: bannerURL) }
            }
            
            var images: [UIImage?] = []
            for await result in taskGroup {
                images.append(result)
            }
            return images
        }
        
        for x in 0..<banners.count {
            let page = UIImageView(frame: CGRect(
                x: CGFloat(x) * view.frame.size.width,
                y: 0,
                width: view.frame.size.width,
                height: view.frame.size.width))
            page.image = banners[x]
            imageScrollView.addSubview(page)
        }
        setupPageControl(banners.count)
    }
    
    private func updateExampleImages(_ viewModel: DetailViewModel) async {
        let exampleURLs = viewModel.exampleImages
        
        for exampleURL in exampleURLs {
            let image = await imageManager.loadImage(url: exampleURL)
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleAspectFit
            let heightRatio = CGFloat(image?.size.height ?? 0) / CGFloat(image?.size.width ?? 0)
            imageView.image = image?.resize(
                withSize: CGSize(width: view.frame.width,
                                 height: view.frame.width * heightRatio),
                contentMode: .contentAspectFit)
            exampleImageStackView.addArrangedSubview(imageView)
        }
    }
}
