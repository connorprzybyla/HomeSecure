//
//  HomeViewModel.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Combine
import Firebase
import UIKit

protocol HomeViewModelable {
    func getSecurityImage(completionHandler: @escaping (UIImage?) -> Void)
}

class HomeViewModel: HomeViewModelable {
    private let urlSession: URLSession
    
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
        
    func getSecurityImage(completionHandler: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://ece-554.appspot.com/data/dummyImage.jpeg")

        storageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
          if let error = error {
              print("Logger: an error has occured. \(error)")
          } else {
            // Data for "images/island.jpg" is returned
              guard let data = data else { return }
              completionHandler(UIImage(data: data))
          }
        }
        
    }
}
