//
//  CharacterListViewTests.swift
//  MavelCharactersTests
//
//  Created by Munir Ahmed on 29/07/2023.
//

import XCTest
@testable import MavelCharacters

final class CharacterListViewModelTests: XCTestCase {
    
    var viewModel: CharacterListViewModel! = CharacterListViewModel()
    var marvelService: MarvelAPIServiceMock!
    
    override func setUp() {
        marvelService = MarvelAPIServiceMock()
        viewModel.service = marvelService
    }
    
    override func tearDown() {
        marvelService = nil
        viewModel = nil
    }
    
    func testSuccessFetchOfCharacters() {
        let expectation = self.expectation(description: "TestCharacterFetch")
        var result: Result<MervelCharacterAPIResponse, Error> = .failure(ApiCustomError.invalidData)
        viewModel.loadData() { error in
            guard error == nil else { return }
            let character = self.viewModel[0]
            result = .success(MervelCharacterAPIResponse(value: [character!], count: 1))
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if case .failure(let error) = result {
            XCTFail(error.localizedDescription)
        } else {
            XCTAssert(true)
        }
    }
    
    
    func testFailFetchOfHeroes() {
        marvelService.shouldFailRequest = true
        
        let expectation = self.expectation(description: "TestCharacterFailFetch")
        var result: Result<MervelCharacterAPIResponse, Error> = .success(MervelCharacterAPIResponse(value: [], count: 0))
        viewModel.loadData { error in
            guard error == nil
            else {
                result = .failure(error!)
                expectation.fulfill()
                return
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if case .success(let characters) = result {
            XCTFail("Should return error but got \(characters) instead")
        } else {
            XCTAssert(true)
        }
    }
}
