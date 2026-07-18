//
//  HorizontalView.swift
//  Movies
//
//  Created by Dewith Andres Miramon Barrios on 18/07/26.
//

import SwiftUI

struct HorizontalListView: View {
    let header : String
    var titles = [Constants.testTitleURL, Constants.testTitleURL2, Constants.testTitleURL3]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(header).font(.title)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(titles, id:\.self) { title in
                        AsyncImage(url: URL(string: title)) {image in
                            image
                                .resizable()
                                .frame(width: 120, height: 200)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            ProgressView()
                        }

                    }
                }
            }
            .frame(height: 200)
        }
        .padding(12)
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMovieString)
}
