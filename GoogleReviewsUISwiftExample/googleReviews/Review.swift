//
//  Review.swift
//  ParkFinderKit
//
//  Created by bwells on 11/16/22.
//

import Foundation

struct Result: Codable {
    var result: Review
}

struct Review: Codable {
    var icon: String
    var reviews: [Reviews]
    var rating: Double
    var name:String
}

struct Reviews: Codable {
    var author_name: String
    var rating: Int
    var relative_time_description: String
    var text: String
    var time: Int
}

