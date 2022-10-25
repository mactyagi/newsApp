//
//  newsAppTests.swift
//  newsAppTests
//
//  Created by manukant tyagi on 21/10/22.
//

import XCTest
@testable import newsApp

final class newsViewModelTestCases: XCTestCase {
    var newsModel = NewsViewModel()

    func test_empty_search_string_with_page_return_success(){
        //ARRANGE
        newsModel.searchString = ""
        newsModel.page = 1
        let expectation = expectation(description: "search_string_with_page_return_success")
        
//        //ACT
        newsModel.fetchTopHeadlinesNews { result in
         
            //ASSERT
            switch result{
            case .success(let data):
                XCTAssertEqual(self.newsModel.articles.count, data.count)
            case .failure(_):
                XCTAssertEqual(self.newsModel.page, 0)
            }
            
            XCTAssertTrue(self.newsModel.isSearch == false)
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_search_string_with_page_return_success(){
        //ARRANGE
        var newsModel = NewsViewModel()
        newsModel.searchString = "india"
        newsModel.page = 1
        let expectation = expectation(description: "search_string_with_page_return_success")
        
//        //ACT
        newsModel.fetchTopHeadlinesNews { result in
         
            //ASSERT
            switch result{
                
            case .success(let data):
                XCTAssertEqual(newsModel.articles.count, data.count)
            case .failure(_):
                XCTAssertEqual(newsModel.page, 0)
            }
            XCTAssertTrue(newsModel.isSearch)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    
    func test_empty_search_string_with_2_page_return_success(){
        //ARRANGE
        newsModel.searchString = ""
        newsModel.page = 2
        
        let expectation = expectation(description: "search_string_with_page_return_success")
        
//        //ACT
        newsModel.fetchTopHeadlinesNews { result in
         
            //ASSERT
            switch result{
            case .success(let data):
                XCTAssertGreaterThanOrEqual(self.newsModel.articles.count, data.count)
            case .failure(_):
                XCTAssertEqual(self.newsModel.page, 1)
            }
            
            XCTAssertTrue(self.newsModel.isSearch == false)
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    
    func test_search_string_with_2_page_return_success(){
        //ARRANGE
        newsModel.searchString = "india"
        newsModel.page = 2
        
        let expectation = expectation(description: "search_string_with_page_return_success")
        
//        //ACT
        newsModel.fetchTopHeadlinesNews { result in
         
            //ASSERT
            switch result{
            case .success(let data):
                XCTAssertGreaterThanOrEqual(self.newsModel.articles.count, data.count)
            case .failure(_):
                XCTAssertEqual(self.newsModel.page, 1)
            }
            XCTAssertTrue(self.newsModel.isSearch)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_change_time_to_Remaining_time_with_empty_string_return_empty_string(){
        let str = newsModel.changeDateToRemainTime(string: "")
        XCTAssertEqual(str, "")
        XCTAssertFalse(str.count > 0)
    }
    
    func test_change_time_to_Remaining_time_with_wrong_date_string_return_empty_string(){
        let str = newsModel.changeDateToRemainTime(string: "2022-10-24")
        XCTAssertEqual(str, "")
        XCTAssertFalse(str.count > 0)
    }
    
    func test_change_time_to_Remaining_time_with_right_date_string_return_empty_string(){
        let str = newsModel.changeDateToRemainTime(string: "2022-10-24T02:53:05Z")
        XCTAssertTrue(str.count > 0)
    }
}
