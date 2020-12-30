//
//  OverviewListRowView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 30.10.20.
//

import SwiftUI

struct OverviewListRowView: View {
    @ObservedObject var item: PicsumPhoto
    
    var body: some View {
        VStack(spacing: 10) {
            NavigationLink(destination: ImageDetailsView(image: item)) {
                Image(uiImage: item.thumb)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
                    .overlay(
                        HStack {
                            Text("\(item.metaData.author)")
                                .bold()
                                .font(.caption)
                                .padding()
                                .lineLimit(1)
                        }
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        
                        ,alignment: .bottom
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .contentShape(Rectangle())
        .overlay(
            // Favorite overlay
            HStack {
                Spacer()
                
                Button(
                    action: {
                        item.objectWillChange.send()
                        item.toggleFavorite()
                    },
                    label: {
                        Image(systemName: item.favorite ? "star.fill" : "star")
                            .padding(5)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                )
                .foregroundColor(item.favorite ? Color.yellow : Color.black)
                .buttonStyle(PlainButtonStyle())
            }
            .frame(maxWidth: .infinity)
            .padding(5)
            
            ,alignment: .topTrailing
        )
        .frame(maxWidth: 600)
    }
}
