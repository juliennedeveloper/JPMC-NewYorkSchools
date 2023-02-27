//
//  ContentView.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/23/23.
//

import Combine
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SchoolsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
