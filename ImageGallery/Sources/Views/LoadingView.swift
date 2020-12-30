//
//  LoadingView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 30.10.20.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "arrow.2.circlepath")
            }
            .rotationEffect(Angle.degrees(isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
            .onAppear { self.isAnimating = true }
            
            Text("Loading images...")
        }
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
