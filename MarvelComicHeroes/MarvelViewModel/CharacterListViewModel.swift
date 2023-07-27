//
//  CharacterListViewModel.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation
import AppKit

class CharacterListViewModel: NSObject {
    private let tableView: NSTableView
    private var data: [MarvelCharacter]! = []
    private let service = MarvelAPIService.shared
    
    init(tableView: NSTableView) {
        self.tableView = tableView
    }
    
    // Function to load more data when needed.
    func loadMoreData() {
    }
    
    // Function to get the number of rows in the table view.
    func numberOfRows() -> Int {
        return data.count
    }
    
    // Function to get the data for a specific row.
    //func valueForRow(at index: Int) -> YourDataModel? {
     //   guard index >= 0 && index < data.count else { return nil }
     //   return data[index]
   // }
}

