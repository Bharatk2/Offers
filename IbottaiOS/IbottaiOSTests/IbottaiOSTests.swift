//
//  IbottaiOSTests.swift
//  IbottaiOSTests
//
//  Created by Bharat Kumar on 4/19/21.
//

import XCTest
@testable import IbottaiOS
class IbottaiOSTests: XCTestCase {
    
    let timeout: TimeInterval = 5
    
    func testFetchAllOffers() throws {
        let expectation = self.expectation(description: "fetching offer is succesfull")
        try OfferController.shared.fetchOffers { offers, error in
            XCTAssertNil(error)
            XCTAssert((offers != nil))
            print("these are succesfull offers: \(offers)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
    }
    
    func testDecoding() throws {
        guard let fileLocation = Bundle.main.url(forResource: "Offers", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Data decodes from the json")
        do {
            let fileData = try Data(contentsOf: fileLocation)
            let data = try XCTUnwrap(fileData)
            XCTAssertNoThrow(
                try JSONDecoder().decode([OfferRepresentation].self, from: data)
                
            )
            print(data)
        } catch { }
        expectation.fulfill()
        waitForExpectations(timeout: timeout)
    }

}
