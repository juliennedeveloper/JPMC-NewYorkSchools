//
//  SchoolDetailView.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import Combine
import MapKit
import SafariServices
import SwiftUI

struct SchoolDetailView: View {
    @State private var region: MKCoordinateRegion
    @State private var isShowingWebsite: Bool = false
    @ObservedObject private var viewModel: SchoolDetailViewModel
    
    init(school: School) {
        self.viewModel = SchoolDetailViewModel(school: school)
        self.region = school.region
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.orange)
                    .scaleEffect(2)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        // General information
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viewModel.school.name)
                                .font(.system(.title, weight: .bold))
                            
                            Text("\(viewModel.school.address) \(viewModel.school.city), \(viewModel.school.state) \(viewModel.school.zip)")
                                .font(.system(.subheadline))
                                .foregroundColor(.gray)
                            
                            Text(viewModel.school.phoneNumber)
                                .font(.system(.caption))
                            
                            if let website = viewModel.school.httpsLink {
                                Button(action: { self.openWebsite() }) {
                                    Text(website)
                                        .underline()
                                        .font(.system(.caption))
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                        
                        // SAT Scores
                        VStack(alignment: .leading, spacing: 8) {
                            Text("SAT Scores")
                                .font(.system(.headline, weight: .bold))
                                .padding(.top)
                            
                            HStack(alignment: .center) {
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    Text("Math")
                                        .font(.system(.headline))
                                    Text("\(viewModel.math)")
                                        .font(.system(.body))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    Text("Reading")
                                        .font(.system(.headline))
                                    Text("\(viewModel.reading)")
                                        .font(.system(.body))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    Text("Writing")
                                        .font(.system(.headline))
                                    Text("\(viewModel.writing)")
                                        .font(.system(.body))
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 8)
                            .padding(.top, 8)
                        }
                        
                        // Sports
                        if let sports = viewModel.school.schoolSports {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Sports")
                                    .font(.system(.headline, weight: .bold))
                                    .padding(.top, 20)
                                
                                Text(sports)
                            }
                        }
                        
                        // Subway
                        VStack(alignment: .leading) {
                            Text("Subway Lines")
                                .font(.system(.headline, weight: .bold))
                                .padding(.top, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.school.subwayLines, id: \.hashValue) { line in
                                        Text(String(line))
                                            .foregroundColor(.white)
                                            .font(.system(.title3, weight: .bold))
                                            .padding()
                                            .frame(width: 50, height: 50)
                                            .background(viewModel.subwayColor(for: line))
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(8)
                        }
                        
                        // Location
                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.system(.headline, weight: .bold))
                                .padding(.top, 20)
                            
                            Map(coordinateRegion: $region, annotationItems: [viewModel.school.annotationItem]) { item in
                                MapMarker(coordinate: item.coordinate)
                            }
                            .frame(height: 300)
                            .cornerRadius(12)
                            .allowsHitTesting(false)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowingWebsite) {
            if let website = viewModel.school.httpsLink, let url = URL(string: website) {
                SafariView(url: url)
            } else {
                Text("Invalid URL")
            }
        }
        .onAppear {
            viewModel.fetchScores()
        }
    }
    
    private func openWebsite() {
        isShowingWebsite.toggle()
    }
}

struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

// SwiftUI wrapper to keep the website opening inside the app
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
