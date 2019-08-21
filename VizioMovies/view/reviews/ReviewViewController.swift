//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ReviewViewController: UIViewController {
    var movie: Movie
    var reviews = [Review]()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        view.backgroundColor = UIColor.white
    }
    
    lazy var reviewsView: ReviewsView = {
        let rv = ReviewsView(movieId: self.movie.id)
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let thumbnailImageView: CachedImageView = {
            let imageView = CachedImageView()
            imageView.backgroundColor = UIColor.lightGray
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        view.addSubview(thumbnailImageView)
        view.addSubview(reviewsView)
        
        
        //gifview constraints
        view.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        //ReviewsView constraints
        reviewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reviewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reviewsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: reviewsView, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: reviewsView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
        
    }
    
    func fetchReviews() {
        let reviewUrl = "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=64b6f3a69e5717b13ed8a56fe4417e71"
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
                                self.reviews.append(newReview)
                            }
                        }
                    }
                }
                //                DispatchQueue.main.sync { [weak self] in
                //todo: may need to do this on a new thread
                self.reviewsView.collectionView.reloadData()
                //                }
                
            } catch {
                print(error)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
