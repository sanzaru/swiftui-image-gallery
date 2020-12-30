//
//  OverviewListView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 30.10.20.
//

import SwiftUI

struct OverviewListView: View {
    var list: [PicsumPhoto] = [] 
    var noDataTitle: String = "No entries"
    
    @State private var columns: CGFloat = 2
    
    var body: some View {
        if list.isEmpty {
            VStack {
                Text(noDataTitle)
                    .foregroundColor(.secondary)
                    .font(.largeTitle)
                    .padding()
            }
        } else {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        VStack(spacing: 10) {
                            OverviewListHeaderActionsView(columns: $columns)
                                .frame(maxWidth: 300)
                            
                            Text("Tap an image to view details")
                                .foregroundColor(.secondary)
                        }
                        .font(.caption)
                        .padding()
                                        
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(self.list.chunked(by: Int(columns)), id: \.self) { row in
                                HStack(spacing: 10) {
                                    ForEach(row, id: \.self) { item in
                                        OverviewListRowView(item: item)
                                            .frame(width: colSize(geo), height: colSize(geo))
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
    
    private func colSize(_ geo: GeometryProxy) -> CGFloat {
        (geo.size.width / columns) - 5
    }
}

struct OverviewListView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewListView()
    }
}
