//
//  HomeViewModel.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Combine
import UIKit

protocol HomeViewModelable {
    func getSecurityImage() -> AnyPublisher<UIImage, APIError>
}

class HomeViewModel: HomeViewModelable {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func getSecurityImage() -> AnyPublisher<UIImage, APIError> {
        guard let imageURL = URL(string: "https://source.unsplash.com/user/c_v_r"),
              let data = try? Data(contentsOf: imageURL) else {
            return Fail(error: APIError.unableToDownload)
                .eraseToAnyPublisher()
        }
        guard let image = UIImage(data: data) else {
            return Fail(error: APIError.unableToDownload)
                .eraseToAnyPublisher()
        }
        
        return Just(image)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
