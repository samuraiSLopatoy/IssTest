//
//  NetworkService.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllBusStops(completion: @escaping (Result<SearchResults, Error>) -> Void)
    func getOneBusStop(idOfBusStop: String, completion: @escaping (Result<OneBusStop2, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private func getGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let fetchedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getAllBusStops(completion: @escaping (Result<SearchResults, Error>) -> Void) {
        let urlString = "https://api.mosgorpass.ru/v8.2/stop"
        getGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func getOneBusStop(idOfBusStop: String, completion: @escaping (Result<OneBusStop2, Error>) -> Void) {
        let urlString = "https://api.mosgorpass.ru/v8.2/stop/\(idOfBusStop)"
        getGenericJSONData(urlString: urlString, completion: completion)
    }
    
}
