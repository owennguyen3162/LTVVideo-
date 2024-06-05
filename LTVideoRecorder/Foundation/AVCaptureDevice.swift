//
//  AVCaptureDevice.swift
//  LTVideoRecorder
//
//  Created by leo on 2018/12/29.
//  Copyright © 2018 ltebean. All rights reserved.
//

import AVFoundation

extension AVCaptureDevice {
    
    static func backCamera() -> AVCaptureDevice {
        return captureDeviceWithPosition(.back)!
    }
    
    static func frontCamera() -> AVCaptureDevice {
        return captureDeviceWithPosition(.front)!
    }
    
    fileprivate static func captureDeviceWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
            [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera],
            mediaType: .video, position: .unspecified)
        let devices = discoverySession.devices
            guard !devices.isEmpty else { fatalError("Missing capture devices.")}

            return devices.first(where: { device in device.position == position })!
    }
    
}
