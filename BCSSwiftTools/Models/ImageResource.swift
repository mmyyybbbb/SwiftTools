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
    
    /// Загружает изображение и кеширует
    /// Работает только для .url
    public func downloadAndCache() {
        guard case let .url(url) = self else { return }
        ImageLoader.shared.load(by: url, completion: { _ in })
    }
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

extension ImageResource: Codable {
    private enum CodingKeys: String, CodingKey {
        case url
    }
     
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(String.self, forKey: .url) {
            guard let url = URL(string: value) else { throw CodingError.decoding("Cant create URL from \(value)")}
            self = .url(url)
            return
        }
        throw CodingError.unsupportedCase("Whoops! \(dump(values))")
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .url(let url):
            try container.encode(url.absoluteString, forKey: .url)
        default : throw CodingError.unsupportedCase("\(self)")
        }
    }
}


public enum CodingError: Error {
    case decoding(String)
    case encoding(String)
    case unsupportedCase(String)
}
