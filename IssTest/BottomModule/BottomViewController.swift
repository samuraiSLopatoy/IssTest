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
        stackView.spacing = 16
        
        // layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 4),
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2)
        ])
    }
    
}

// MARK: - BottomView Protocol

extension BottomViewController: BottomViewProtocol {
    
    func setUIElements(oneBusStop2: OneBusStop2) {
        nameLabel.text = "🚏 Станция:" + " " + oneBusStop2.name
        nameLabel.numberOfLines = 0
        
        let typeString = (oneBusStop2.routePath.first?.type ?? "неизвестен 😞")
        switch typeString {
        case "bus": typeLabel.text = "Тип маршрута: Автобус 🚌"
        case "tram": typeLabel.text = "Тип маршрута: Трамвай 🚋"
        case "train": typeLabel.text = "Тип маршрута: Поезд 🚉"
        default: typeLabel.text = "Тип маршрута: Неизвестен 😞"
        }
        
        numberLabel.text = "🆔 Номер маршрута:" + " " + (oneBusStop2.routePath.first?.number ?? "Неизвестен 😔")
        timeArrivalLabel.text = "🕓 Время до прибытия:" + " " + (oneBusStop2.routePath.first?.timeArrival.first ?? "Неизвестно 😩")
    }
}
