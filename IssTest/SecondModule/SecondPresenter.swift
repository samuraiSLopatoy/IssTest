//
//  SecondPresenter.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import Foundation

protocol SecondPresenterProtocol {
    init(view: SecondViewProtocol, networkService: NetworkServiceProtocol, busStop1: BusStop1)
    var busStop1: BusStop1? { get set }
    func getOneBusStop()
}

class SecondPresenter: SecondPresenterProtocol {
    
    unowned let view: SecondViewProtocol
    let networkService: NetworkServiceProtocol
    
    var busStop1: BusStop1?
    
    required init(view: SecondViewProtocol, networkService: NetworkServiceProtocol, busStop1: BusStop1) {
        self.view = view
        self.networkService = networkService
        self.busStop1 = busStop1
    }
    
    // 2
    func getOneBusStop() {
        networkService.getOneBusStop(idOfBusStop: busStop1!.id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let oneBusStop2):
                    self.view.setOneBusStop(oneBusStop2: oneBusStop2)
                    
                case .failure(let error):
                    self.view.showAlert(with: error)
                }
            }
        }
    }
    
}
