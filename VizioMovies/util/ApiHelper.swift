//
//  ApiHelper.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/21/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import Foundation
import Alamofire

class ApiHelper {
    
    static func fetchMovies(searchPhrase: String, onComplete: @escaping ([Movie]) -> ()) {
        var movies = [Movie]()
        let search = searchPhrase.replacingOccurrences(of: " ", with: "+")
        let searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=64b6f3a69e5717b13ed8a56fe4417e71&query=\(search)"
        AF.request(searchUrl).responseJSON { response in
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
                if let dictionary = json as? [String: Any] {
                    if let results = dictionary["results"] as? [Any] {
                        for m in results {
                            if let movie = m as? [String: Any] {
                                let id = movie["id"] as! Int
                                let title = movie["title"] as! String
                                let imageUrl = "https://image.tmdb.org/t/p/w500\(movie["poster_path"] ?? "")"
                                let description = movie["overview"] as! String
                                let newMovie = Movie(id: id, title: title, imageUrl: imageUrl, description: description)
                                movies.append(newMovie)
                            }
                        }
                    }
                }
                onComplete(movies)
                
            } catch {
                print(error)
            }
        }
    }
    
    static func fetchReviews(movieId: Int, onComplete: @escaping ([Review]) -> ()) {
        var reviews = [Review]()
        let reviewUrl = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=64b6f3a69e5717b13ed8a56fe4417e71"
        AF.request(reviewUrl).responseJSON { response in
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
                if let dictionary = json as? [String: Any] {
                    if let results = dictionary["results"] as? [Any] {
                        for r in results {
                            if let review = r as? [String: Any] {
                                let id = review["id"] as! String
                                let author = review["author"] as! String
                                let content = review["content"] as! String
                                let newReview = Review(id: id, author: author, content: content)
                                reviews.append(newReview)
                            }
                        }
                    }
                }
                onComplete(reviews)
                
            } catch {
                print(error)
            }
        }
    }
}
