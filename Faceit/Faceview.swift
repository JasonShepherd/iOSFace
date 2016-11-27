//
//  Faceview.swift
//  Faceit
//
//  Created by Jason Shepherd on 11/27/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import UIKit

class Faceview: UIView {
    
    private var scale: CGFloat = 0.90
    private var headRadius: CGFloat{
        
        return   min(bounds.size.width,bounds.size.height) / 2
    }
    var headCenter: CGPoint{
        
        return CGPoint (x:bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios{
        static let headToEyeOffset: CGFloat = 3
        static let headToEyeRadius: CGFloat = 10
        static let headToMouthWidth: CGFloat = 1
        static let headToMouthHeight: CGFloat = 3
        static let headToMouthffset: CGFloat = 3
    }
    
    private enum Eye{
        case Left
        case Right
    }
    private func getEyeCenter(eye:Eye)->CGPoint{
        let eyeOffset = headRadius / Ratios.headToEyeOffset
        var eyeCenter = headCenter
        eyeCenter.y -= eyeOffset
        switch eye{
        case .Left: eyeCenter.x -= eyeOffset
        case.Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathforEye(eye: Eye)->UIBezierPath
    {
        let eyeRadius = headRadius / Ratios.headToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        return pathForCircleCenterAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
        
    }
    
    private func pathForCircleCenterAtPoint(midPoint:CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius, startAngle: 0.0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0
        return path
    }
    
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = headRadius / Ratios.headToMouthWidth
        let mouthHeight = headRadius / Ratios.headToMouthHeight
        let mouthOffset = headRadius / Ratios.headToMouthffset
        let mouthRect = CGRect(
            x: headCenter.x - mouthWidth / 2,
            y: headCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight)
        return UIBezierPath(rect:mouthRect)
        
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCircleCenterAtPoint(midPoint: headCenter, withRadius: headRadius).stroke()
        pathforEye(eye: .Left).stroke()
        pathforEye(eye: .Right).stroke()
        pathForMouth().stroke()
        
    }
    
    
}
