//
//  Resize.swift
//  LTVideoRecorder
//
//  Created by Nguyễn Linh on 05/06/2024.
//  Copyright © 2024 ltebean. All rights reserved.
//

import UIKit

class Resize {
    
    static let shared = Resize()
    
    private init {}
    
    func pixelPerfect () -> CGSize {
        let iPhone13MiniSize = CGSize(width: 375, height: 812)
        let currentScreenSize = UIScreen.main.bounds.size

        let originalSize = CGSize(width: 100, height: 50)
        let adjustedSize = originalSize.adjusted(for: iPhone13MiniSize, relativeTo: currentScreenSize)
        
        return adjustedSize
    }
}
