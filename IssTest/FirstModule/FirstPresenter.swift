//
//  FirstPresenter.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import Foundation

protocol FirstPresenterProtocol {
    init(view: FirstViewProtocol, networkService: NetworkServiceProtocol)
    var busStops1: [BusStop1] { get }
    func getAllBusStops()
}

class FirstPresenter: FirstPresenterProtocol {
    
    unowned let view: FirstViewProtocol
    let networkService: NetworkServiceProtocol
    
    var busStops1: [BusStop1] = []
    
    required init(view: FirstViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    // 2
    func getAllBusStops() {
        networkService.getAllBusStops { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResults):
                    self.busStops1 = searchResults.data
                    self.view.setAllBusStops()
                    
                case .failure(let error):
                    self.view.showAlert(with: error)
                }
            }
        }
    }
    
}
