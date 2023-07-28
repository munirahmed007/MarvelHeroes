//
//  String+Marvel.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Foundation

extension String {
    init(from description: String?) {
        self = "No description"
        if let value = description,
           !value.isEmpty {
            self = value
        }
    }
}
