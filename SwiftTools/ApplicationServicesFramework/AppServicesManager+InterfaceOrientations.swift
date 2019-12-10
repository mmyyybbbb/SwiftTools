//
//  AppServicesManager+Orientations.swift
//  BrokerApp
//
//  Created by Андрей Раевнёв on 25/05/2019.
//  Copyright © 2019 Andrey Raevnev. All rights reserved.
//


import UIKit

extension PluggableApplicationDelegate {
    
    open func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

        var supportedOrientation: UIInterfaceOrientationMask = .portrait
        for service in _services {
            if let orientation = service.application?(application, supportedInterfaceOrientationsFor: window) {
                 supportedOrientation = orientation
            }
        }
        return supportedOrientation
    }
    
}

