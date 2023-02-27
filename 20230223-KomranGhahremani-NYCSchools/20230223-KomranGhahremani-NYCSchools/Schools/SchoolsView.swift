//
//  SchoolsView.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import SwiftUI

struct SchoolsView: View {
    @ObservedObject var viewModel = SchoolsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.orange)
                    .scaleEffect(2)
            } else {
                List(viewModel.schools, id: \.dbn) { school in
                    NavigationLink(destination: SchoolDetailView(school: school)) {
                        SchoolTableCell(school: school)
                    }
                }
            }
        }
        .navigationTitle("NYC Schools")
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}
