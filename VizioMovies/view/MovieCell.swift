//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//
import UIKit

class MovieCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var movie: Movie? {
        didSet {
            thumbnailImageView.loadImageUsingUrlString(urlString: movie!.imageUrl)
            titleLabel.text = movie!.title
            subtitleTextView.text = String(movie!.description.prefix(130)) + "..."
        }
    }

    let thumbnailImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie Title Here"
        return label
    }()

    let subtitleTextView: UITextView = {
        let textView = UITextView()
    
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        return textView
    }()

    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)

        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: subtitleTextView)

        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1]-8-[v2]-8-[v3(1)]|", views: thumbnailImageView, titleLabel, subtitleTextView, separatorView)

        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)

        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))

        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
