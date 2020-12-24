//
//  ImageLoader.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public class ImageLoader {
    
    public static let shared = ImageLoader()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    public func image(by string: String, completion: @escaping ((UIImage?) -> Void)) {
        load(by: URL(string: string)!, completion: completion)
    }
    
    public func load(by url: URL, completion: @escaping ((UIImage?) -> Void)) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(image)
            return
        }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data) ?? UIImage()
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image)
                }
            } catch {
                debugPrint("ImageLoader error! \(url.absoluteString) - is not image url")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
