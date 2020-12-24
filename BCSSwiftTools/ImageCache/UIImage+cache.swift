//
//  UIImage+cache.swift
//  SwiftTools
//
//  Created by Andrey Raevnev on 06/08/2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageCacheLoadCompletion = ([String: UIImage]) -> Void

public extension UIImage {
    
    func trySaveToFile(dirName: String, fileName: String) {
        DispatchQueue.global().async {
            
            if let data = self.jpegData(compressionQuality: 1.0),
                let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let cacheDir = dir.appendingPathComponent(dirName)
                let fileUrl = cacheDir.appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: fileUrl.absoluteString) { return }
                
                do {
                    if !FileManager.default.fileExists(atPath: cacheDir.absoluteString) {
                        try FileManager.default.createDirectory(atPath: cacheDir.relativePath, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                    try data.write(to: fileUrl, options: .atomic)
                     
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
    
    static func loadFromDirectory(dirName: String, extension: String = "", completion: @escaping ImageCacheLoadCompletion) {
        DispatchQueue.global().async {
            
            var dict: [String: UIImage] = [:]

            guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let cacheDir = dir.appendingPathComponent(dirName)
            
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDir, includingPropertiesForKeys: nil)
                fileURLs.forEach { fileUrl in
                    let image = UIImage(contentsOfFile: fileUrl.path)
                    let name = fileUrl.lastPathComponent
                    dict[name] = image
                }

                DispatchQueue.main.async {
                    
                    debugPrint("loadFromDirectory count", dict.count)
                    completion(dict)
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
}
