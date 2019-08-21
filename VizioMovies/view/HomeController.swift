//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UICollectionViewController, UISearchBarDelegate {
    
    var movies = [Movie]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Movies"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: "cellId")
        
        //setup search
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Movie"
        searchController.searchBar.setValue("Search", forKey: "cancelButtonText")
        searchController.searchBar.text = "Star Wars"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        fetchMovies(searchPhrase: "Star Wars")
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
    
    //this cancel button is overrided to be Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchMovies(searchPhrase: searchController.searchBar.text!)
    }
    
    func fetchMovies(searchPhrase: String) {
        movies = [Movie]()
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

