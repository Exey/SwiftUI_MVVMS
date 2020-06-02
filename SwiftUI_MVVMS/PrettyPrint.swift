//
//  PrettyPrint.swift
//  SwiftUI_MVVMS
//
//  Created by exey on 21.04.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import Foundation
//import os.log
//os_log()

/** short and beautiful print */
func pp(_ object: Any?) {
    #if DEBUG
        if let object = object {
            pp("⚪️ \(object)")
        } else {
            pp("⚪️ \(String(describing: object))")
        }
    #endif
}
func pp(_ text: String, terminator: String? = nil) {
    #if DEBUG
        terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}
