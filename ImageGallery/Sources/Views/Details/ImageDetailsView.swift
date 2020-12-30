//
//  ImageDetailsView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI
import SimpleToast


struct ImageDetailsView: View {
    @ObservedObject var image: PicsumPhoto
    
    @State private var showSaveToast: Bool = false
    @State private var showErrorToast: Bool = false
    @State private var showImageFullscreen: Bool = false
    
    private let imageSaver: PhotoLibraryService = PhotoLibraryService()
    private let toastOptions = SimpleToastOptions(delay: TimeInterval(3), backdrop: false, modifierType: .slide)
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    // The image
                    Image(uiImage: image.image)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture { showImageFullscreen.toggle() }
                        .onTapGesture(count: 2) { image.toggleFavorite() }
                    
                    // Action buttons
                    HStack(spacing: 20) {
                        Button(
                            action: { image.toggleFavorite() },
                            label: {
                                VStack(spacing: 10) {
                                    Image(systemName: image.favorite ? "star.fill" : "star")
                                    Text("\(image.favorite ? "Remove" : "Add") favorite")
                                }
                            }
                        )
                        
                        Button(
                            action: { saveImage() },
                            label: {
                                VStack(spacing: 10) {
                                    Image(systemName: "square.and.arrow.down")
                                    Text("Save in photos")
                                }
                            }
                        )
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Image meta data
                    ImageDetailsMetadataView(image: image)
                }
                .frame(maxWidth: 600)
            }
            
            // Fullscreen view
            ImageDetailsFullscreenView(image: image, showFullscreen: $showImageFullscreen)
        }
        .simpleToast(isShowing: $showSaveToast, options: toastOptions) {
            // Success message
            HStack {
                Text("Saved photo in your library.")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
        }
        .simpleToast(isShowing: $showErrorToast, options: toastOptions) {
            // Error message
            HStack {
                Text("Error saving photo. Please check the settings.")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
        }
        .navigationTitle("\(image.metaData.author)")
        .navigationBarHidden(showImageFullscreen)
        .statusBar(hidden: showImageFullscreen)
    }
    
    
    // MARK: - Private methods
    
    /// Save the image to the user's library
    private func saveImage() {
        self.imageSaver.successHandler = {
            self.showSaveToast = true
        }
        self.imageSaver.errorHandler = { _ in
            self.showErrorToast = true
        }
        self.imageSaver.writeToLibrary(image: image.image)
    }
}
