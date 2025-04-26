//
//  AppDelegate.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//
import Foundation

// MARK: -  MAIN SOURCE URL

var APISourceURL: String {
    if is_live {
        return "http://sunshinetodo.test/api/"
    }else {
        return "http://sunshinetodo.test/api/"
    }
}

