//
//  ThemeButtonView.swift
//  SunRiseExpenseTracker
//
//  Created by Suraj kahar on 29/03/25.
//

import SwiftUI

struct ThemeButtonView: View {
    
    var title: String
    
    var font : Font = .system(size: 20, weight: .semibold)
    var backgroundColor: Color = ._7_F_3_DFF
    var foregroundColor: Color = .FCFCFC
    var cornerRadius: CGFloat = 16.0
    var height : CGFloat = 50.0
    
    
    var body: some View {
        Text(title) // Directly using the binding value for title
            .font(font)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(backgroundColor) // Replace with your custom color
            .foregroundColor(foregroundColor) // Set text color
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
}

