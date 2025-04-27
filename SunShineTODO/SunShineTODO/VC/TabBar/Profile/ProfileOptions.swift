//
//  ProfileOptions.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

enum ProfileOptions: CaseIterable {
    
    case settings
    case logout
    
    
    var title: String {
        return switch self {
        case .settings: "Settings"
        case .logout: "Logout"
        }
    }
    
    var image: UIImage {
        return switch self {
        case .settings : .profileSettingsIcon
        case .logout : .profileLogoutIcon
        }
    }
    
    var tintColor: UIColor {
        return switch self {
        case .settings: ._7_F_3_DFF
        case .logout: .FD_3_C_4_A
            
        }
    }
    
    var bgColor: UIColor {
        return switch self {
        case .settings: .EEE_5_FF
        case .logout: .FFE_2_E_4
            
        }
    }
    
}
