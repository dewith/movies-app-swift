//
//  ViewModel.swift
//  Movies
//
//  Created by Dewith on 2026-07-21.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()

    var trendingMovies: [Title] = []

    func getTitles() async {
        homeStatus = .fetching

        do {
            trendingMovies = try await dataFetcher.fetchTitles(for: "movie")
            Constants.addPosterPath(to: &trendingMovies)
            homeStatus = .success
        } catch {
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }

}
