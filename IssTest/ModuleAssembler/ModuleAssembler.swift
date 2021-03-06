//
//  ModuleAssembler.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import UIKit

protocol ModuleAssemblerProtocol {
    static func createFirstModule() -> UIViewController
    static func createSecondModule(busStop1: BusStop1) -> UIViewController
    static func createBottomModule(oneBusStop2: OneBusStop2) -> UIViewController
}

class ModuleAssembler: ModuleAssemblerProtocol {
    
    static func createFirstModule() -> UIViewController {
        let view = FirstViewController()
        let networkService = NetworkService()
        let presenter = FirstPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createSecondModule(busStop1: BusStop1) -> UIViewController {
        let view = SecondViewController()
        let networkService = NetworkService()
        let presenter = SecondPresenter(view: view, networkService: networkService, busStop1: busStop1)
        view.presenter = presenter
        return view
    }
    
    static func createBottomModule(oneBusStop2: OneBusStop2) -> UIViewController {
        let view = BottomViewController()
        let presenter = BottomPresenter(view: view, oneBusStop2: oneBusStop2)
        view.presenter = presenter
        return view
    }
}
