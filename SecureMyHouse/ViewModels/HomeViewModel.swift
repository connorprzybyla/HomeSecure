//
//  HomeViewModel.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Combine
import Foundation
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
        Fail(error: APIError.notSupported).eraseToAnyPublisher()
    }
}
