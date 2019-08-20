//
//  Movie.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/20/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int
    var imageUrl: String
    var title: String
    var description: String
    
    init(id: Int, title: String, imageUrl: String, description: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.description = description
    }
}
