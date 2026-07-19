//
//  Title.swift
//  Movies
//
//  Created by Dewith on 2026-07-18.
//

import Foundation

struct APIObject: Decodable {
    var results:  [Title] = []
}

struct Title: Decodable, Identifiable {
    var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
}



