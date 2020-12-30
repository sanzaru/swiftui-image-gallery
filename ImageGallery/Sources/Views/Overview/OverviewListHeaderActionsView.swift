//
//  OverviewListHeaderActionsView.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 31.10.20.
//

import SwiftUI


struct OverviewListHeaderActionsView: View {
    @Binding var columns: CGFloat
    @State private var showHeaderActions: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "rectangle.grid.2x2")
                        Text("Column configuration")
                        Spacer()
                    }
                    
                    Spacer()
                    Image(systemName: showHeaderActions ? "chevron.up" : "chevron.down")
                }
            }
            .padding()
            .background(Color("OverviewActionsBackground"))
            .foregroundColor(Color("OverviewActionsForeground"))
            .cornerRadius(10)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation { showHeaderActions.toggle() }
            }
            
            VStack {
                Group {
                    Text("Show \(Int(columns)) columns")
                    Slider(value: $columns, in: 1...4, step: 1)
                }
            }
            .padding()
            .frame(minHeight: 0, maxHeight: showHeaderActions ? .infinity : 0)
            .clipped()
        }
    }
}
