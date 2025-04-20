//
//  Log.swift
//  iOSSampleApp
//
//  Created by Igor Kulman on 23/07/2020.
//  Copyright © 2020 Igor Kulman. All rights reserved.
//

import Foundation
import OSLog

extension os.Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let data = os.Logger(subsystem: subsystem, category: "data")
    static let appFlow = os.Logger(subsystem: subsystem, category: "appFlow")
    
}
