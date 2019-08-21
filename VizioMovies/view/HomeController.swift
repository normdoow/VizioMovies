//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit

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
        
        resetMovies(searchPhrase: "Star Wars")
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reviewController = ReviewViewController(movie: movies[indexPath.item])
        self.navigationController?.pushViewController(reviewController, animated: true)
    }
    
    //this cancel button is overrided to be Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetMovies(searchPhrase: searchController.searchBar.text!)
    }
    
    func resetMovies(searchPhrase: String) {
        ApiHelper.fetchMovies(searchPhrase: searchPhrase, onComplete: { movies in
            self.movies = movies
//            DispatchQueue.main.sync { [weak self] in
                self.collectionView.reloadData()
//            }
        })
    }


}

