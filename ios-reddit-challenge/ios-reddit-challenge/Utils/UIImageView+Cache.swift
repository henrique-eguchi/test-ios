//
//  UIImageView+Cache.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 08/05/21.
//


import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func imageFromURL(_ imageURL: URL) {
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: imageURL.absoluteString as AnyObject)
                    self.image = image
                }
            })
        }.resume()
    }
    
}
