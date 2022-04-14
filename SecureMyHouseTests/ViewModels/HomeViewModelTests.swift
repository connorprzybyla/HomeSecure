//
//  HomeViewModelTests.swift
//  SecureMyHouseTests
//
//  Created by Connor Przybyla on 4/9/22.
//

import Combine
import Foundation
import XCTest

@testable import SecureMyHouse

class HomeViewModelTests: XCTestCase {
    var subject: HomeViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        let urlSession = URLSession(configuration: .default)
        subject = HomeViewModel(urlSession: urlSession)
    }
    
    override func tearDown() {
        subject = nil
    }
    
    func testGetSucurityImageEmitsExpectedUIImage() {
        var didFinish = false
        subject.getSecurityImage()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure: break
                case .finished:
                    didFinish = true
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
        
        XCTAssertTrue(didFinish)
    }
    
}
