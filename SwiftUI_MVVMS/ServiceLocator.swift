//
//  ServiceLocator.swift
//  SwiftUI_MVVMS
//
//  Created by exey on 21.04.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import Foundation


protocol Serviceable {}


final class ServiceLocator {

    private var registry = [ObjectIdentifier: Any]()
    static var assembly = ServiceLocator() // shared

    private init() {
        registerFirstServices()
    }

    // MARK: - Declaration

    func registerFirstServices() {
        // REGISTERING SERVICES
        registerSingleton(singletonInstance: CoreSecureStorageService())
        registerSingleton(singletonInstance: Analytics())
        register(factory: {
            Obfuscator()
        })
        
   
    }

    // MARK: - Registration

    func register<Service>(factory: @escaping () -> Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = factory
    }

    func registerSingleton<Service>(singletonInstance: Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = singletonInstance
    }

    // MARK: - Injection

    func inject<Service>() -> Service {
        let serviceId = ObjectIdentifier(Service.self)
        if let factory = registry[serviceId] as? () -> Service {
            return factory()
        } else if let singletonInstance = registry[serviceId] as? Service {
            return singletonInstance
        } else {
            fatalError("No registered entry for \(Service.self)")
        }
    }
}
