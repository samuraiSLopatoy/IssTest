//
//  SecondViewController.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol SecondViewProtocol: AnyObject {
    func setOneBusStop(oneBusStop2: OneBusStop2)
    func showAlert(with error: Error)
}

class SecondViewController: UIViewController {
    
    var presenter: SecondPresenterProtocol!
    
    private let mapView = MKMapView()
    private let xButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupMapView()
        setupXButton()
        
        // 1
        presenter.getOneBusStop()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        
        // layout
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupXButton() {
        mapView.addSubview(xButton)
        xButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        xButton.tintColor = .black
        
        // action
        xButton.addTarget(self, action: #selector(closeMap), for: .touchUpInside)
        
        // layout
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.topAnchor.constraint(equalToSystemSpacingBelow: mapView.topAnchor, multiplier: 8).isActive = true
        xButton.leftAnchor.constraint(equalToSystemSpacingAfter: mapView.leftAnchor, multiplier: 4).isActive = true
    }
    
    @objc private func closeMap() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - SecondView Protocol

extension SecondViewController: SecondViewProtocol {
    
    // 3
    func setOneBusStop(oneBusStop2: OneBusStop2) {
        // здесь каким-то UI элементам присваиваим штуки из параметра этой функции
        setupPlacemark(lat: oneBusStop2.lat,
                       lon: oneBusStop2.lon,
                       name: oneBusStop2.name)
    }
    
    func showAlert(with error: Error) {
        let alert = AlertFactory.showAlert(with: error)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup Placemark

extension SecondViewController {
    
    private func setupPlacemark(lat: Double, lon: Double, name: String) {
        var annotationsArray: [MKPointAnnotation] = []
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lat,
                                                   longitude: lon)) { [weak self] placemarks, error in
            if let error = error {
                print(error)
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat,
                                                           longitude: lon)
            
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            self?.mapView.showAnnotations(annotationsArray, animated: false)
        }
    }
}
