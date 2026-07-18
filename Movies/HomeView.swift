//
//  HomeView.swift
//  Movies
//
//  Created by Dewith Andres Miramon Barrios on 17/07/26.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: heroTestTitle)){image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            HStack {
                Button {
                    
                } label: {
                    Text(Constants.playString)
                        .regularButtonStyle()
                }
                
                Button {
                    
                } label: {
                    Text(Constants.downloadString)
                        .regularButtonStyle()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
