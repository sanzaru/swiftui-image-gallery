//
//  ContentView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI
import CoreData

struct OverviewMainView: View {
    @ObservedObject private var photoList: PicsumPhotoList = PicsumPhotoList()
    
    @State private var isInit = false    
    @State private var currentTab = 1
    
    private enum tabTitles: String {
        case all = "Overview", favorites = "Favorites"
    }
    
    private var favorites: [PicsumPhoto] {
        return photoList.list.filter { $0.favorite }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {                
                // Overview tab
                OverviewListView(list: photoList.list)
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text(tabTitles.all.rawValue)
                    }
                    .tag(1)
                
                // Favorites tab
                OverviewListView(list: favorites, noDataTitle: "No favorites")
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text(tabTitles.favorites.rawValue)
                    }
                    .tag(2)
                    
            }
            .navigationTitle(currentTab == 1 ? tabTitles.all.rawValue : tabTitles.favorites.rawValue)
            .navigationBarHidden(false)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay (
            // Loading overlay
            LoadingView()
                .opacity(isInit ? 0 : 1)
                .animation(Animation.linear(duration: 0.4))
        )
        .onAppear {
            photoList.fetch { self.isInit = $0 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
