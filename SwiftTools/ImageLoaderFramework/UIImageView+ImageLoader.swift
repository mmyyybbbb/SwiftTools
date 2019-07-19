//
//  UIImageView+ImageLoader.swift
//  YandexInvestition
//
//  Created by Сергей Климов on 31.08.2018.
//  Copyright © 2018 BCS. All rights reserved.
//

public extension UIImageView {

    func setImage(with string: String?) {
        guard let string = string else {
            image = nil
            return
        }
        ImageLoader.shared.image(by: string) { [weak self] in self?.image = $0 }
    }

    func setImage(with url: URL) {
        ImageLoader.shared.load(by: url) { [weak self] in self?.image = $0 }
    }

}
