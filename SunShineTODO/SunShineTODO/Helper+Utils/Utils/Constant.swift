//
//  Constant.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit

// add the aspect ratio of the device screen from your targeted figma design
let figmaDesignScreenHeight: CGFloat = 932
let figmaDesignScreenWidth: CGFloat = 430

let aspectRatio: CGSize = CGSize(width: figmaDesignScreenWidth, height: figmaDesignScreenHeight)


func getHeightRelativeToScreenHeight(_ height : CGFloat) -> CGFloat{
    (UIScreen.main.bounds.height * height) / figmaDesignScreenHeight
}

func getWidthRelativeToScreenWidth(_ width : CGFloat) -> CGFloat{
    (UIScreen.main.bounds.width * width) / figmaDesignScreenHeight
}


let isSmallerDevice : Bool = {
    return (UIScreen.main.bounds.width <= 375 && UIScreen.main.bounds.height <= 667)
}()


// SET THE FLAG TO PRINT FUNCTION IN PROJECT
var isPrintAllowed = is_live ? false : true

var is_live: Bool {
#if DEBUG
    return false
#else
    return true
#endif
}


let noInternetConnectionErrorStatusCode : Int = 999

// CLOSURE
typealias VoidClosure = () -> Void
typealias PassStringClosure = (String) -> Void
typealias PassBoolClosure = (Bool) -> Void


// OTHER DataTypes
typealias StringToStringDict = [String : String]
typealias StringAnyDict = [String : Any]
typealias StringAnyDictArray = [[String : Any]]


// MARK: - URL CONSTANTS

class URLConstants{

    static var localFileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var settingUrl = UIApplication.openSettingsURLString
    static var bleSettings = "App-prefs:Bluetooth"
    static var locationSettings = "App-prefs:LOCATION_SERVICES"
    
}
