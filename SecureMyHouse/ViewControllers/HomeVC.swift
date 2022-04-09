//
//  HomeVC.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/6/22.
//

import UIKit

class HomeVC: UIViewController {
            
    private let scrollView = UIScrollView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var currentImage: UIImage = {
        let image = UIImage()
        return image
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
    
    init() {
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
    }
    
    private func configurePullDownToRefresh() {
        scrollView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    // MARK: Selectors
    
    @objc func refresh(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            print("Data saved, we're done!")
            self?.refreshControl.endRefreshing()
        }
    }
    
    // MARK: Private
    
    private func configureScrollView() {
        stackView.addArrangedSubview(homeLabel)
        stackView.addArrangedSubview(refreshButton)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }

    private func configureAutoViewConstraints() {
        scrollView.setConstraints(equalTo: view)
        stackView.setConstraints(equalTo: scrollView)
    }
}
