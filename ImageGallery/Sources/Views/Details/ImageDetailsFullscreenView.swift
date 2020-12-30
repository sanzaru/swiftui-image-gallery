//
//  ImageDetailsFullscreenView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 31.10.20.
//

import SwiftUI

struct ImageDetailsFullscreenView: View {
    @ObservedObject var image: PicsumPhoto
    @Binding var showFullscreen: Bool
    
    var body: some View {
        VStack {
            Image(uiImage: image.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .opacity(showFullscreen ? 1 : 0)
        .zIndex(10)
        .onTapGesture { showFullscreen = false }
    }
}

