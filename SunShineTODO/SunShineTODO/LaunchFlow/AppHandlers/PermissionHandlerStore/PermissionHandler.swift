//
//  PermissionHandler.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation
import AVFAudio


class PermissionHandler : LaunchFlow {
    
    static let shared = PermissionHandler()
    
    private init(
 
    ) {
        self.microphoneHandler = MicrophonePermissionHandler.shared
        self.cameraHandler = CameraPermissionHandler.shared
    }
    
    var microphoneHandler : MicrophonePermissionHandler
    var cameraHandler : CameraPermissionHandler
   
    func start() {
        microphoneHandler.start()
        cameraHandler.start()
    }
   
}
