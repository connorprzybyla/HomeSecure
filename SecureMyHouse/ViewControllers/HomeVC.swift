//
//  HomeVC.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/6/22.
//

import Combine
import UIKit

class HomeVC: UIViewController {
    
    private let viewModel: HomeViewModelable
    private let scrollView = UIScrollView()
    private var subscriptions = Set<AnyCancellable>()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }()
        
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Monitor Home Security"
        
        return label
    }()
    
    private let refreshButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .large
        configuration.title = "Capture Image"
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Connecting to camera...")
        
        return refreshControl
    }()
    
    init(viewModel: any HomeViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureScrollView()
        configureAutoViewConstraints()
        configurePullDownToRefresh()
        bindImage()
    }
    
    private func configurePullDownToRefresh() {
        scrollView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    // MARK: Selectors
    
    @objc func refresh(_ sender: Any) {
        forceUpdateImage()
    }
    
    @objc func didTapCapture(_ sender: UIEvent) {
        forceUpdateImage()
    }
    
    // MARK: Private
    
    private func forceUpdateImage() {
        DispatchQueue.main.async {
            _ = self.viewModel.getSecurityImage()
                .sink(receiveCompletion: { [weak self] completion in
                    if case let .failure(apiError) = completion {
                        print("Unable to retreive image. Error: \(apiError)")
                        self?.refreshControl.endRefreshing()
                    }
                }, receiveValue: { [weak self] image in
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.refreshControl.endRefreshing()
                    }
                })
        }
    }
    
    private func configureScrollView() {
        refreshButton.addTarget(self, action: #selector(didTapCapture), for: .touchUpInside)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(refreshButton)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }

    private func configureAutoViewConstraints() {
        scrollView.setConstraints(equalTo: view)
        stackView.setConstraints(equalTo: scrollView)
    }
    
    private func bindImage() {
        viewModel.getSecurityImage()
            .sink(receiveCompletion: { completion in
                if case let .failure(apiError) = completion {
                    print("Unable to retreive image. Error: \(apiError)")
                }
            }, receiveValue: { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }).store(in: &subscriptions)
    }
}
