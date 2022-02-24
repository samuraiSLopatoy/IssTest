//
//  FirstModel.swift
//  IssTest
//
//  Created by Михаил Кулагин on 23.02.2022.
//

import Foundation

// https://api.mosgorpass.ru/v8.2/stop
// model 1

struct SearchResults: Decodable {
    let data: [BusStop1]
}

struct BusStop1: Decodable {
    let id: String
    let name: String
}
