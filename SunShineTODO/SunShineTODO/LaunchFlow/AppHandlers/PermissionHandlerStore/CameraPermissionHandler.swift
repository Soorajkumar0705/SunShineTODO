//
//  CameraPermissionHandler.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation
import AVFAudio
import AVFoundation
import UIKit

extension Notification.Name {
    static let didChangeCameraPermissionStatus = Notification.Name("didChangeCameraPermissionStatus")
}

class CameraPermissionHandler : LaunchFlow {
    
    static let shared = CameraPermissionHandler()
    
    private init() { }
    
    var isCameraEnabled: Bool {
        checkIsCameraEnabled()
    }

    
    func start() {
        Logger.logMessage("\(className) is started successfully.")
    }
    
    
    private func checkIsCameraEnabled() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
    
        return switch status {
        case .authorized: true  // Camera access granted
        case .denied, .restricted: false // Camera access denied
        case .notDetermined: false
        @unknown default: false
        }
    }
    
    func checkAndRequestCameraPermission(){
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
    
        switch status {
        case .authorized: break;  // Camera access granted
        case .denied, .restricted: // Camera access denied
            showCustomAlertForCameraPermission()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] isGranted in
                guard let _ = self else { return }
                NotificationCenter.default.post(name: .didChangeCameraPermissionStatus, object: nil)
            })
        @unknown default: break;
        }
        
    }
    
    private func showCustomAlertForCameraPermission() {
        guard let activeVC = AppDelegate.getAppDelegateRef()?.getActiveVC() else { return }
        
        let alert = UIAlertController(title: "Camera Access Denied",
                                      message: "Please enable Camera access in Settings.",
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
