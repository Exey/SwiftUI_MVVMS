//
//  Analytics.swift
//  SwiftUI_MVVMS
//
//  Created by exey on 21.04.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import Foundation

enum AnalyticsEvent: String {
    case appOpen = "App_Open"
}


extension Analytics {
    
    static var injected: Analytics {
        let a: Analytics = ServiceLocator.assembly.inject()
        return a
    }
    
}

final class Analytics: Serviceable {
    
    func sendToSDK(_ name: AnalyticsEvent, _ properties: [AnyHashable: Any]? = nil) {
        pp("send event \(name) \(String(describing: properties))")
    }
    
    func event(_ name: AnalyticsEvent, _ properties: [AnyHashable: Any]? = nil) {
        sendToSDK(name, properties)
        
    }
    
}
