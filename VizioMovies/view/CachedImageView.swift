//
//  ViewController.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CachedImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        if let u = url {
            URLSession.shared.dataTask(with: u as URL, completionHandler: { (data, respones, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.main.sync { [weak self] in
                    
                    let imageToCache = UIImage(data: data!)
                    
                    if self!.imageUrlString == urlString {
                        self!.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
                
            }).resume()
        } else {
            image = nil
        }
    }
    
}
