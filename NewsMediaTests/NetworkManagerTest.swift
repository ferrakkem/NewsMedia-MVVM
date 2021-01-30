//
//  NetworkManagerTest.swift
//  CBCMediaTests
//
//  Created by Ferrakkem Bhuiyan on 2020-12-09.
//

import XCTest
@testable import CBCMedia

class NetworkManagerTest: XCTestCase {
    
    private var netwrokM: NetwrokManager!
    
    override func setUp() {
        super.setUp()
        self.netwrokM = NetwrokManager()
    }

    func test_API_BaseURLString_IsCorrect() {
        let baseURLString = EndPointDetails.newEndPoint
        let expectedBaseURLString = "https://www.cbc.ca/aggregate_api/v1/items?lineupSlug=news&categorySet=cbc-news-apps&typeSet=cbc-news-apps-feed-v2&excludedCategorySet=cbc-news-apps-exclude&page=1&pageSize=20"
        XCTAssertEqual(baseURLString, expectedBaseURLString, "Base URL does not match expected base URL. Expected base URLs to match.")
    }
    
    
    func test_Parse() {
        let _ : ((Result<NewsModel, Error>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Failed")
            case .success( _):
                XCTAssert(true, "Succes")
            }
        }
    }
    
    func test_Decoding() throws {
        // When the Data initializer is throwing an error, the test will fail.
        let jsonData = try Data(contentsOf: URL(string: EndPointDetails.newEndPoint)!)
        // The `XCTAssertNoThrow` can be used to get extra context about the throw
        XCTAssertNoThrow(try JSONDecoder().decode([NewsModel].self, from: jsonData))
    }
    
    
    func test_Response_Count() throws {
        let data = try Data(contentsOf: URL(string: EndPointDetails.newEndPoint)!)
        let response = try JSONDecoder().decode([NewsModel].self, from: data)
        XCTAssertEqual(response.count, 20)
    }
    
    // Asynchronous test: success fast, failure slow
    func test_Status_Code_200() {
        let sut: URLSession!
        sut = URLSession(configuration: .default)
      // given
      let url = URL(string: EndPointDetails.newEndPoint)
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
}
