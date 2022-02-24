//
//  BottomPresenter.swift
//  IssTest
//
//  Created by Михаил Кулагин on 24.02.2022.
//

import Foundation

protocol BottomPresenterProtocol {
    init(view: BottomViewProtocol, oneBusStop2: OneBusStop2?)
    var oneBusStop2: OneBusStop2? { get }
    func setUIElements()
}

class BottomPresenter: BottomPresenterProtocol {
    
    unowned let view: BottomViewProtocol
    
    var oneBusStop2: OneBusStop2?
    
    required init(view: BottomViewProtocol, oneBusStop2: OneBusStop2?) {
        self.view = view
        self.oneBusStop2 = oneBusStop2
    }
    
    func setUIElements() {
        view.setUIElements(oneBusStop2: oneBusStop2!)
    }

}
