//
//  Review.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/21/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import Foundation

class Review {
    
    var id: String
    var author: String
    var content: String
    
    init(id: String, author: String, content: String) {
        self.id = id
        self.author = author
        self.content = content
    }
}
