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
        let capturedUrl = url
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            guard capturedUrl == url else { return }
            completion(image)
            return
        }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data) ?? UIImage()
                DispatchQueue.main.async { [weak self] in
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
                    guard capturedUrl == url else { return }
                    completion(image)
                }
            } catch {
                completion(nil)
                debugPrint("ImageLoader error! \(url.absoluteString) - is not image url")
            }
        }
        
        UIImage.loadFromDirectory(dirName: "T##String") { dict in
            
            
        }
        
    }
}
