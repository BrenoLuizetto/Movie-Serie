//
//  HomeViewControllerSpec.swift
//  InfoCineTest
//
//  Created by Breno Luizetto on 18/06/22.
//

import XCTest
import Quick
import Nimble
@testable import Movie_Serie

class HomeViewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: HomeViewController!
        var navController: UINavigationController?
        
        beforeEach {
            sut = HomeViewController()
            navController = UINavigationController(rootViewController: sut)
        }
        
        describe("testing") {
            describe("ViewController") {

                it("call ViewDidLoad") {
                    expect(sut.viewDidLoad).notTo(beNil())
                }
                
                it("call ViewWillAppear") {
                    expect(sut.viewWillAppear(true)).notTo(beNil())
                }
                
                
                it("has right navigation bar button") {
                    expect(sut.navigationItem.rightBarButtonItem).notTo(beNil())
                }
                
                it("has right navigation bar button action") {
                    if let rightBarButtonItem = sut.navigationItem.rightBarButtonItem {
                        XCTAssertTrue(rightBarButtonItem.action?.description == "search")
                    } else {
                        XCTAssertTrue(false)
                    }
                }
                
                it("has left navigation bar button") {
                    expect(sut.navigationItem.leftBarButtonItem).notTo(beNil())
                }
                 
                it("has left navigation bar button action") {
                    if let leftBarButtonItem = sut.navigationItem.leftBarButtonItem {
                        XCTAssertTrue(leftBarButtonItem.action?.description == "userMenu")
                    } else {
                        XCTAssertTrue(false)
                    }
                }
            }
            
            describe("functions") {
                it("did receive observable update favorite movies") {
                    expect(NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateFavoriteMovies"),
                                                           object: nil)).notTo(beNil())
                }
                
                it("refresh control action") {
                    expect(sut.refreshControl.sendActions(for: .valueChanged)).notTo(beNil())
                }
            }
        }
    }
    
}
