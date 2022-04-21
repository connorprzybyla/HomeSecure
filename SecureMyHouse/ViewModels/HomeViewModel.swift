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
    func getSecurityImage(completionHandler: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://ece-554.appspot.com/data/photo.jpg")
        
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Logger: an error has occured. \(error)")
            }
            
            guard let data = data else { return }
            completionHandler(UIImage(data: data))
        }
    }
}
