//
//  UIImageView.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((UIImage?) -> Void)? = nil) {
        
        guard let encodedString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedString) else {
                
            if let completion = completion {
                completion(nil)
            } else {
                image = nil
            }
            
            return
        }
        
        if let completion = completion {
            ImageCache.publicCache.load(url: url as NSURL, completion: completion)
        } else {
            image = nil
            alpha = 0
            
            ImageCache.publicCache.load(url: url as NSURL) { [weak self] image in
                UIView.animate(withDuration: 0.3) {
                    self?.image = image
                    self?.alpha = 1
                }
            }
        }
    }
    
}
