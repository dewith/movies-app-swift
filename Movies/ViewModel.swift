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
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []

    func getTitles() async {
        homeStatus = .fetching

        do {
            async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
            async let tShows = dataFetcher.fetchTitles(for: "tv", by: "trending")
            async let tRMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
            async let tRShows = dataFetcher.fetchTitles(for: "tv", by: "top_rated")

            trendingMovies = try await tMovies
            trendingTV = try await tShows
            topRatedMovies = try await tRMovies
            topRatedTV = try await tRShows

            Constants.addPosterPath(to: &trendingMovies)
            Constants.addPosterPath(to: &trendingTV)
            Constants.addPosterPath(to: &topRatedMovies)
            Constants.addPosterPath(to: &topRatedTV)

            homeStatus = .success
        } catch {
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }

}
