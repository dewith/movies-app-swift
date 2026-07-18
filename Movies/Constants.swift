//
//  Constants.swift
//  Movies
//
//  Created by Dewith Andres Miramon Barrios on 17/07/26.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"

    static let homeIconString = "house"
    static let upcomingIconString = "calendar"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
}


extension Text {
    func regularButtonStyle() -> some View {
        self
            .frame(width: 120, height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background {
                RoundedRectangle(
                    cornerRadius: 50,
                    style: .continuous
                )
                .fill(.button)
            }
    }
}
