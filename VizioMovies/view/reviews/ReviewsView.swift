//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit

class ReviewsView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    var movieId: Int
    var reviews = [Review]()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(ReviewCell.self, forCellWithReuseIdentifier: "ReviewCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    func resetReviews() {
        ApiHelper.fetchReviews(movieId: movieId, onComplete: { reviews in
            self.reviews = reviews
//            DispatchQueue.main.sync { [weak self] in
                self.collectionView.reloadData()
//            }
        })
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(frame: CGRect())
        
        addSubview(collectionView)
        
        //Add constraint
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        resetReviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.review = reviews[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
