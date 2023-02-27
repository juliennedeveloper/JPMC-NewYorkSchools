//
//  School.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/23/23.
//

import MapKit
import Foundation

struct School: Codable {
    var dbn: String
    var name: String
    var address: String
    var city: String
    var zip: String
    var state: String
    var phoneNumber: String
    var totalStudents: String
    var latitude: String?
    var longitude: String?
    var schoolSports: String?
    var website: String?
    var email: String?
    var subway: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case address = "primary_address_line_1"
        case city
        case zip
        case state = "state_code"
        case phoneNumber = "phone_number"
        case totalStudents = "total_students"
        case latitude
        case longitude
        case schoolSports = "school_sports"
        case website
        case email = "school_email"
        case subway
    }
    
    // Helpers
    var subwayLines: [Character] {
        subway?.components(separatedBy: ",")
            .compactMap({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .compactMap({ $0.first }) ?? []
    }
    
    // with more time would like to do something similar to the subway lines with the different sports
    var sports: [String] {
        subway?.components(separatedBy: ",")
            .compactMap({ $0.trimmingCharacters(in: .whitespacesAndNewlines) }) ?? []
    }
    
    var region: MKCoordinateRegion {
        let latitude = CLLocationDegrees(Double(latitude ?? "45")!)
        let longitude = CLLocationDegrees(Double(longitude ?? "45")!)

        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    var annotationItem: AnnotationItem {
        let latitude = CLLocationDegrees(Double(latitude ?? "45")!)
        let longitude = CLLocationDegrees(Double(longitude ?? "45")!)
        
        return AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    var httpsLink: String? {
        guard let website = website else { return nil }
        return "https://" + website
    }
}
