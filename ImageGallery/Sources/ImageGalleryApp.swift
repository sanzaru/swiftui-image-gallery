//
//  ImageGalleryApp.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI

@main
struct ImageGalleryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            OverviewMainView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
