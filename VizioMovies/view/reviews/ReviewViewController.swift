//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit
import Foundation

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
            imageView.loadImageUsingUrlString(urlString: movie.imageUrl)
            return imageView
        }()
        
        let labelView: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Reviews"
            label.font = UIFont(name: label.font.fontName, size: 20)
            label.textColor = UIColor.darkGray
            return label
        }()
        
        view.addSubview(thumbnailImageView)
        view.addSubview(labelView)
        view.addSubview(reviewsView)
        
        
        //gifview constraints
        view.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: 0, constant: 150))
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        //label constraints
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-0-|", views: labelView)
        view.addConstraint(NSLayoutConstraint(item: labelView, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //ReviewsView constraints
        reviewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reviewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reviewsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: reviewsView, attribute: .top, relatedBy: .equal, toItem: labelView, attribute: .bottom, multiplier: 1, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: reviewsView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
