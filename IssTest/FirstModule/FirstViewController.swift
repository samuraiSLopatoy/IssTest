//
//  ViewController.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import UIKit

protocol FirstViewProtocol: AnyObject {
    func setAllBusStops()
    func showAlert(with error: Error)
}

class FirstViewController: UIViewController {
    
    var presenter: FirstPresenterProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupTableView()
        
        // 1
        presenter.getAllBusStops()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView data source

extension FirstViewController: UITableViewDataSource {
    
    // 3
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.busStops1.count
    }
    
    // 4
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let busStop = presenter.busStops1[indexPath.row]
        cell.textLabel?.text = busStop.name
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

// MARK: - TableView delegate

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let busStop1 = presenter.busStops1[indexPath.row]
        let secondVC = ModuleAssembler.createSecondModule(busStop1: busStop1)
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }
}

// MARK: - FirstView Protocol

extension FirstViewController: FirstViewProtocol {
    
    // 5
    func setAllBusStops() {
        tableView.reloadData()
    }
    
    func showAlert(with error: Error) {
        let alert = AlertFactory.showAlert(with: error)
        present(alert, animated: true, completion: nil)
    }
}
