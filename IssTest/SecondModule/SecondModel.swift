//
//  SecondModel.swift
//  IssTest
//
//  Created by Михаил Кулагин on 24.02.2022.
//

import Foundation

// https://api.mosgorpass.ru/v8.2/stop/00014195-8703-4ee1-a55a-cc6421c2bd8f
// model 2

struct OneBusStop2: Decodable {
    let name: String
    let routePath: [RoutePath]
    let lat: Double
    let lon: Double
}

struct RoutePath: Decodable {
    let type: String
    let number: String
    let timeArrival: [String]
}
