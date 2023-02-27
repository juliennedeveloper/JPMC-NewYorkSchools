//
//  SchoolTableCell.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import SwiftUI

struct SchoolTableCell: View {
    let school: School
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(school.name)
                .font(.system(.callout, weight: .bold))
            Text("\(school.address) \(school.city), \(school.state) \(school.zip)")
                .font(.system(.subheadline))
                .foregroundColor(.gray)
        }
    }
}
