//
//  PluggableApplicationDelegate.swift
//  PluggableApplicationDelegate
//
//  Created by Fernando Ortiz on 2/24/17.
//  Copyright © 2017 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

/// This is only a tagging protocol.
/// It doesn't add more functionalities yet.
public protocol ApplicationService: UIApplicationDelegate {}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
 
    open var services: [ApplicationService] { return [] }

    internal lazy var _services: [ApplicationService] = {
        return self.services
    }()

    @discardableResult
    internal func apply<T, S>(_ work: (ApplicationService, @escaping (T) -> Void) -> S?, completionHandler: @escaping ([T]) -> Swift.Void) -> [S] {
        let dispatchGroup = DispatchGroup()
        var results: [T] = []
        var returns: [S] = []
        
        for service in _services {
            dispatchGroup.enter()
            let returned = work(service, { result in
                results.append(result)
                dispatchGroup.leave()
            })
            if let returned = returned {
                returns.append(returned)
            } else { // delegate doesn't impliment method
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completionHandler(results)
        }
        
        return returns
    }
 
    @discardableResult
    internal func apply<S>(_ work: (ApplicationService, @escaping () -> Void) -> S?, completionHandler: @escaping () -> Swift.Void) -> [S] {
        let dispatchGroup = DispatchGroup()
        var returns: [S] = []
        
        for service in _services {
            dispatchGroup.enter()
            let returned = work(service, {
                dispatchGroup.leave()
            })
            
            if let returned = returned {
                returns.append(returned)
            } else { // delegate doesn't impliment method
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completionHandler()
        }
        
        return returns
    }
}
