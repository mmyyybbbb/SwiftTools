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
