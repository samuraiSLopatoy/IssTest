//
//  BottomViewController.swift
//  IssTest
//
//  Created by Михаил Кулагин on 24.02.2022.
//

import UIKit

protocol BottomViewProtocol: AnyObject {
    func setUIElements(oneBusStop2: OneBusStop2)
}

class BottomViewController: UIViewController {
    
    var presenter: BottomPresenterProtocol!
    
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let numberLabel = UILabel()
    private let timeArrivalLabel = UILabel()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                                typeLabel,
                                                                numberLabel,
                                                                timeArrivalLabel])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
        
        // 1
        presenter.setUIElements()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 4),
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 4),
            stackView.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 4)
        ])
    }
    
}

// MARK: - BottomView Protocol

extension BottomViewController: BottomViewProtocol {
    
    func setUIElements(oneBusStop2: OneBusStop2) {
        nameLabel.text = "Станция: \(oneBusStop2.name)"
        typeLabel.text = "Тип маршрута: \(oneBusStop2.routePath.first!.type)"
        numberLabel.text = "Номер маршрута: \(oneBusStop2.routePath.first!.number)"
        timeArrivalLabel.text = "Время до прибытия: \(oneBusStop2.routePath.first!.timeArrival.first!)"
    }
}
