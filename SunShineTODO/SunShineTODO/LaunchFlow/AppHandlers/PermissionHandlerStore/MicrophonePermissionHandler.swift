//
//  MicrophonePermissionHandler.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation
import AVFAudio
import UIKit


class MicrophonePermissionHandler : LaunchFlow {
    
    static let shared = MicrophonePermissionHandler()
    private init() { }
    
    
    var isMicrophoneEnabled: Bool {
        checkIsMicrophoneEnabled()
    }

    
    func start() {
        Logger.logMessage("\(className) is started successfully.")
    }
    
    private func checkIsMicrophoneEnabled() -> Bool{
        if #available(iOS 17.0, *) {
            print("Running on iOS 17 or later")
            
            return switch AVAudioApplication.shared.recordPermission {
            case .granted: true  // Permission granted
            case .denied: false // Permission denied
            case .undetermined: false
                
            @unknown default: false
            }
            
        } else {
            print("Running on iOS 16 or earlier")
            
            return switch AVAudioSession.sharedInstance().recordPermission {
            case .granted: true  // Permission granted
            case .denied: false // Permission denied
            case .undetermined: false
                
            @unknown default: false
            }
        }
        
    }
    
    func checkAndRequestMicrophonePermission(){
        
        if #available(iOS 17.0, *) {
            print("Running on iOS 17 or later")
            
            switch AVAudioApplication.shared.recordPermission {
            case .granted: break; // Permission granted
            case .denied , .undetermined: // Permission denied
                requestMicrophonePermission()
  
            @unknown default: break;
            }
            
        } else {
            print("Running on iOS 16 or earlier")
            
            switch AVAudioSession.sharedInstance().recordPermission {
            case .granted: break;  // Permission granted
            case .denied , .undetermined: // Permission denied
                requestMicrophonePermission()
                
            @unknown default: break;
            }
        }
        
        
    }
    
    private func requestMicrophonePermission() {
        
        if #available(iOS 17.0, *) {
            print("Running on iOS 17 or later")
            
            let recordPermission = AVAudioApplication.shared.recordPermission
            
            if (recordPermission == .denied ) {
                showCustomAlertForMicrophonePermission()
                
            }else if (recordPermission == .undetermined) {
                
                AVAudioApplication.requestRecordPermission(completionHandler: { [weak self] isGranted in
                    guard let _ = self else { return }
                })
                
            }
        } else {
            let recordPermission = AVAudioSession.sharedInstance().recordPermission
            
            if ( recordPermission == .denied ){
                showCustomAlertForMicrophonePermission()
                
            }else if (recordPermission == .undetermined ){
                
                AVAudioSession.sharedInstance().requestRecordPermission({ [weak self] isGranted in
                    guard let _ = self else { return }
                })
            }
            
        }
        
    }   // private func requestMicrophonePermission() {
    
    private func showCustomAlertForMicrophonePermission() {
        guard let activeVC = AppDelegate.getAppDelegateRef()?.getActiveVC() else { return }
        
        let alert = UIAlertController(title: "Microphone Access Denied",
                                      message: "Please enable Microphone access in Settings.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        activeVC.present(alert, animated: true, completion: nil)
        
        // SHOW CUSTOM POP UP ALERT
    }
    
    
}
