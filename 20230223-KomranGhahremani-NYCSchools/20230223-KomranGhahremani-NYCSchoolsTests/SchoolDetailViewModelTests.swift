//
//  SchoolDetailViewModelTests.swift
//  20230223-KomranGhahremani-NYCSchoolsTests
//
//  Created by Komran Ghahremani on 2/27/23.
//

import SwiftUI
import XCTest

final class SchoolDetailViewModelTests: XCTestCase {
    
    var viewModel: SchoolDetailViewModel!

    override func setUpWithError() throws {
        viewModel = SchoolDetailViewModel(school: School.mock)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSubwayColorGenerator() throws {
        /**
         case "1", "2", "3": return .red
         case "M", "F", "B", "D": return .orange
         case "A", "C", "E": return .blue
         case "4", "5", "6", "G": return .green
         case "Q", "R", "N", "W": return .yellow
         case "7": return .purple
         default: return .gray
         */
        
        XCTAssertEqual(viewModel.subwayColor(for: "1"), Color.red)
        XCTAssertEqual(viewModel.subwayColor(for: "2"), Color.red)
        XCTAssertEqual(viewModel.subwayColor(for: "3"), Color.red)
        
        XCTAssertEqual(viewModel.subwayColor(for: "M"), Color.orange)
        XCTAssertEqual(viewModel.subwayColor(for: "F"), Color.orange)
        XCTAssertEqual(viewModel.subwayColor(for: "B"), Color.orange)
        XCTAssertEqual(viewModel.subwayColor(for: "D"), Color.orange)
        
        XCTAssertEqual(viewModel.subwayColor(for: "A"), Color.blue)
        XCTAssertEqual(viewModel.subwayColor(for: "C"), Color.blue)
        XCTAssertEqual(viewModel.subwayColor(for: "E"), Color.blue)
        
        XCTAssertEqual(viewModel.subwayColor(for: "4"), Color.green)
        XCTAssertEqual(viewModel.subwayColor(for: "5"), Color.green)
        XCTAssertEqual(viewModel.subwayColor(for: "6"), Color.green)
        XCTAssertEqual(viewModel.subwayColor(for: "G"), Color.green)
        
        XCTAssertEqual(viewModel.subwayColor(for: "Q"), Color.yellow)
        XCTAssertEqual(viewModel.subwayColor(for: "R"), Color.yellow)
        XCTAssertEqual(viewModel.subwayColor(for: "N"), Color.yellow)
        XCTAssertEqual(viewModel.subwayColor(for: "W"), Color.yellow)
        
        XCTAssertEqual(viewModel.subwayColor(for: "7"), Color.purple)
        
        XCTAssertEqual(viewModel.subwayColor(for: "L"), Color.gray)
        XCTAssertEqual(viewModel.subwayColor(for: "S"), Color.gray)
        XCTAssertEqual(viewModel.subwayColor(for: "X"), Color.gray)
        
    }
    
}

extension School {
    static let mock: School = {
        School(dbn: "XXXXXX", name: "Fake School", address: "1600 Maryland Lane", city: "Brooklyn", zip: "10004", state: "NY", phoneNumber: "5556667777", totalStudents: "123")
    }()
}
