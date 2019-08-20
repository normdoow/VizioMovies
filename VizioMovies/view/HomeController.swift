//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/15/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UICollectionViewController {
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Movies"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: "cellId")
        
        fetchMovies()
    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MovieCell
        cell.movie = self.movies[indexPath.item]
        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func fetchMovies() {
        movies = [Movie]()
        
        let movieDbUrl = "https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2014-09-15&primary_release_date.lte=2014-10-22&page=1&api_key=64b6f3a69e5717b13ed8a56fe4417e71"
        
        AF.request(movieDbUrl).responseJSON { response in
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
                if let dictionary = json as? [String: Any] {
                    if let results = dictionary["results"] as? [Any] {
                        for m in results {
                            if let movie = m as? [String: Any] {
                                let title = movie["title"] as! String
                                let imageUrl = "https://image.tmdb.org/t/p/w500\(movie["poster_path"] ?? "")"
                                let description = movie["overview"] as! String
                                let newMovie = Movie(title: title, imageUrl: imageUrl, description: description)
                                self.movies.append(newMovie)
                            }
                        }
                    }
                }
//                DispatchQueue.main.sync { [weak self] in
                //todo: may need to do this on a new thread
                    self.collectionView.reloadData()
//                }
                
            } catch {
                print(error)
            }
        }
    }


}

