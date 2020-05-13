//
//  ImageResource.swift
//  YandexInvestition
//
//  Created by alexej_ne on 29/11/2018.
//  Copyright © 2018 BCS. All rights reserved.
//
public enum ImageResource {
    case image(UIImage)
    case url(URL)
    case provider(ImageProvider, imageId: String)
}

public typealias ImageProviderCompletion = (UIImage?) -> Void

public protocol ImageProvider {
    func getImage(identifier: String, completion: @escaping ImageProviderCompletion)
}

extension ImageResource: Equatable {
    public static func == (lhs: ImageResource, rhs: ImageResource) -> Bool {
        switch (lhs, rhs) {
        case (let .image(limg), let .image(rimg)): return limg == rimg
        case (let .url(lurl), let .url(rurl)): return lurl == rurl
        case (let .provider(_, lId), let .provider(_, rId)): return lId == rId
        default: return false
        }
    }
}
 
