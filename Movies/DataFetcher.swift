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
    func fetchTitles(for media:String, by type:String) async throws -> [Title] {

        let fetchTitlesURL = try buildURL(media: media, type: type)
        guard let fetchTitlesURL = fetchTitlesURL else {
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


    private func buildURL(media: String, type: String) throws -> URL? {
        guard let baseURL = tmdbBaseUrl else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }

        var path: String

        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }

        guard let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }

        return url
    }
}
