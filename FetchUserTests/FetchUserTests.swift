//
//  FetchUserTests.swift
//  FetchUserTests
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import XCTest
@testable import FetchUser

class FetchUserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FetchUserList() {
       
        // given
        let authenticationExpectation = expectation(description: "fetchuser")
        var list : [UserModel] = []
        
        NetworkClient.performRequest([UserModel].self, router: APIRouter.getUser, success: { [weak self] (models) in
            list = models
            authenticationExpectation.fulfill()
                  }) { [weak self] (error) in
                    print(error)
               }

        // then
        waitForExpectations(timeout: 2) { _ in
            XCTAssertNotNil(list)
            XCTAssertFalse(list.count == 0)
        }
    }
    
    func test_returnUserList() ->[UserModel] {
       
        // given
        let authenticationExpectation = expectation(description: "returnUserList")
        var list : [UserModel] = []
        
        NetworkClient.performRequest([UserModel].self, router: APIRouter.getUser, success: { [weak self] (models) in
            list = models
            authenticationExpectation.fulfill()
                  }) { [weak self] (error) in
                    print(error)
               }

        // then
        waitForExpectations(timeout: 2) { _ in
            XCTAssertNotNil(list)
            XCTAssertFalse(list.count == 0)
        }
        return list
    }
    
    func test_FetchAndFilterPosts() {
        let userList = self.test_returnUserList()
        let authenticationExpectation = expectation(description: "fetchuser")
        // given
        var posts : [PostModel] = []
        NetworkClient.performRequest([PostModel].self, router: APIRouter.posts, success: { [weak self] (models) in
            authenticationExpectation.fulfill()
                        if models.count > 0{
                                   for post in models{
                                    if post.userID == userList.first?.id {
                                           posts.append(post)
                                       }
                                   }
                               }
                              }) { [weak self] (error) in
                                print(error)
                                XCTAssertFalse(posts.count == 0)
                    }
        // then
               waitForExpectations(timeout: 2) { _ in
                   XCTAssertNotNil(userList)
                   XCTAssertFalse(userList.count == 0)
               }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
