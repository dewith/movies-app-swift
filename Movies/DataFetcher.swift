//
//  DataFetcher.swift
//  Movies
//
//  Created by Dewith on 2026-07-20.
//

import Foundation


struct DataFetcher {
    let tmdbBaseUrl = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey

    // Example URL:
    // https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    func fetchTitles(for media:String) async throws -> [Title] {
        guard let baseURL = tmdbBaseUrl else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }

        guard let fetchTitlesURL = URL(string: baseURL)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }

        print(fetchTitlesURL)

        let (data, urlResponse) = try await URLSession.shared.data(
            from: fetchTitlesURL
        )

        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(
                underlyingError: NSError(
                    domain: "DataFetcher",
                    code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"]
                )
            )
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(APIObject.self, from: data).results
    }
}
