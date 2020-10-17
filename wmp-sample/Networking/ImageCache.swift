//
//  ImageCache.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit

class ImageCache {
    
    public static let publicCache = ImageCache()
    
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?) -> Swift.Void]]()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Swift.Void) {
        
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        URLSession(configuration: .ephemeral).dataTask(with: url as URL) { (data, response, error) in
            
            guard let responseData = data, let image = UIImage(data: responseData),
                let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
}
