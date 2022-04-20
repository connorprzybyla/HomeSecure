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
        stackView.spacing = 10
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Monitoring"
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let refreshButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .medium
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
        view.backgroundColor = .white
        configureScrollView()
        configureAutoViewConstraints()
        configurePullDownToRefresh()
        bindImage()
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
        self.viewModel.getSecurityImage(completionHandler: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.refreshControl.endRefreshing()
            }
        })
    }
    
    private func configureScrollView() {
        refreshButton.addTarget(self, action: #selector(didTapCapture), for: .touchUpInside)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(refreshButton)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }

    private func configureAutoViewConstraints() {
        scrollView.setConstraints(equalTo: view)
        stackView.setConstraints(equalTo: scrollView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 400),
            imageView.heightAnchor.constraint(equalToConstant: 500),
            refreshButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configurePullDownToRefresh() {
        scrollView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    private func bindImage() {
        self.viewModel.getSecurityImage(completionHandler: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.refreshControl.endRefreshing()
            }
        })
    }
}
