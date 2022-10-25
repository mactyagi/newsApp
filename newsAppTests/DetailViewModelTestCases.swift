//
//  DetailViewModelTestCases.swift
//  newsAppTests
//
//  Created by manukant tyagi on 24/10/22.
//

import XCTest
@testable import newsApp

final class DetailViewModelTestCases: XCTestCase {
    
    var detailModel = DetailViewModel()

    func test_change_time_to_Remaining_time_with_empty_string_return_empty_string(){
        let str = detailModel.changeDateToRemainTime(string: "")
        XCTAssertEqual(str, "")
        XCTAssertFalse(str.count > 0)
    }
    
    func test_change_time_to_Remaining_time_with_wrong_date_string_return_empty_string(){
        let str = detailModel.changeDateToRemainTime(string: "2022-10-24")
        XCTAssertEqual(str, "")
        XCTAssertFalse(str.count > 0)
    }
    
    func test_change_time_to_Remaining_time_with_right_date_string_return_empty_string(){
        let str = detailModel.changeDateToRemainTime(string: "2022-10-24T02:53:05Z")
        XCTAssertTrue(str.count > 0)
    }
    
    
}
