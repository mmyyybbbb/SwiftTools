//
//  UIImageView+ImageLoader.swift
//  YandexInvestition
//
//  Created by Сергей Климов on 31.08.2018.
//  Copyright © 2018 BCS. All rights reserved.
//

import UIKit

extension UIImageView: AssociatedStore {
    
    private struct AssociationKey {
        static var currentLogoIdKey = "currentLogoId"
    }
    
    private var currentLogoId: String? {
        get { return associatedObject(forKey: &AssociationKey.currentLogoIdKey, default: nil) }
        set { setAssociatedObject(newValue, forKey: &AssociationKey.currentLogoIdKey) }
    }
    
    private func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }

    
    public  func set(resource: ImageResource?, completion: ((UIImage?) -> Void)? = nil) {
        guard let resource = resource else {
            setImage(nil)
            currentLogoId = nil
            completion?(nil)
            return
        }
        
        switch resource {
        case .image(let img):
            setImage(img)
            completion?(img)
            currentLogoId = nil
        case .url(let url):
            let urlString = url.absoluteString
            guard currentLogoId != urlString else { return }
            currentLogoId = urlString
            setImage(nil)
            ImageLoader.shared.load(by: url) { [weak self] img in
                guard let self = self, self.currentLogoId == url.absoluteString else { return }
                
                guard let img = img else {
                    completion?(nil)
                    self.currentLogoId = nil
                    return
                }
                completion?(img)
                self.setImage(img)
            }
        case let .provider(provider, logoId):
            guard currentLogoId != logoId else { return }
            currentLogoId = logoId
            setImage(nil)
            provider.getImage(identifier: logoId) { [weak self] img in
                guard let self = self, self.currentLogoId == logoId else { return }
                
                guard let img = img else {
                    completion?(nil)
                    self.currentLogoId = nil
                    return
                }
                completion?(img)
                self.setImage(img)
            }
        }
    }
}

