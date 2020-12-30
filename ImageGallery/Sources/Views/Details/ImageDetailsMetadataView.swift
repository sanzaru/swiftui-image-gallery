//
//  ImageDetailsMetadataView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 31.10.20.
//

import SwiftUI

struct ImageDetailsMetadataView: View {
    @State var image: PicsumPhoto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("Author:")
                    .bold()
                
                Text("\(image.metaData.author)")
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .top) {
                Text("Dimensions:")
                    .bold()
                
                Text("\(image.metaData.width) x \(image.metaData.height) px")
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .top) {
                Text("URL:")
                    .bold()
                
                Link("\(image.metaData.url)", destination: URL(string: image.metaData.url)!)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .top) {
                Text("Download:")
                    .bold()
                
                Link("\(image.metaData.downloadUrl)", destination: URL(string: image.metaData.downloadUrl)!)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .font(.caption)
        .padding([.horizontal, .bottom])
    }
}
