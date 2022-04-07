//
//  ViewController.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var currentImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "SecureMyHouse"
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        configureAutoView()
    }
    
    // MARK: Private helpers

    private func configureAutoView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

