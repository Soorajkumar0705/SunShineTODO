//
//  CommonFunctions.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit
import AudioToolbox


//BLOCKED THE PRINT STATEMENTS FROM ALL OVER THE PROJECT

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    // IF PRINT ALLOWED THEN ONLY WILL THE PRINT STATEMENT WORK ELSE NOT PRINT ANYTHING
    if isPrintAllowed{
        items.forEach {
            Swift.print($0, separator: separator, terminator: terminator)
        }
    }
}

class CommonFunctions {
    
    static func printFonts(){
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    static func generateHapticFeedback(value : UINotificationFeedbackGenerator.FeedbackType = .success){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    static func vibrate(){
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    static func playSystemSound(soundId: Int){
        AudioServicesPlaySystemSound(SystemSoundID(soundId))
    }
    
    func preventMobileAutoLock(shouldPrevent: Bool){
        UIApplication.shared.isIdleTimerDisabled = shouldPrevent
    }
    
    static func openWebUrl(urlString: String, with options : [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completion: PassBoolClosure? = nil, getError: PassStringClosure? = nil){
        guard let url = URL(string: urlString) else {
            getError?("Not a valid url.")
            return
        }
        UIApplication.shared.open(url, options: options, completionHandler: completion)
    }
    
    static func saveDataToDisk(image: UIImage, fileName: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        try? image.pngData()?.write(to: fileURL)
    }

    static func loadImageFromDisk(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        let data = try? Data(contentsOf: fileURL)
        return data?.toImage()
    }

    private static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    static func getAttributedString(from text: String, coloredRanges: [(String, UIColor)]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        for (subText, color) in coloredRanges {
            let range = (text as NSString).range(of: subText)
            if range.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        
        return attributedString
    }

    
}


// uicolor init simplified
extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}
