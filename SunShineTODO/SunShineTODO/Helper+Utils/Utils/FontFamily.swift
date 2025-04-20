//
//  FontFamily.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit

enum FontFamily : String{
    
    // Add the fonts manually in ->  info.plist -> Fonts Provided By Application
    
    case kAlbertSansItalic = "AlbertSans-Italic"
    case kAlbertSansBold = "AlbertSans-Bold"
    case kAlbertSansLight = "AlbertSans-Light"
    case kAlbertSansMedium = "AlbertSans-Medium"
    case kAlbertSansRegular = "AlbertSans-Regular"
    case kAlbertSansSemiBold = "AlbertSans-SemiBold"
    case kRobotoLight = "Roboto-Light"
    
    
    func ofSize(_ size: CGFloat) -> UIFont{
        return UIFont(name: rawValue, size: getFontSize(size: size)) ?? UIFont.systemFont(ofSize: getFontSize(size: size))
    }

    private func getFontSize(size: CGFloat) -> CGFloat{
        return (UIScreen.main.bounds.width * size)/aspectRatio.width
    }
    
}
