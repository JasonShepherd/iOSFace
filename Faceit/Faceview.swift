//
//  Faceview.swift
//  Faceit
//
//  Created by Jason Shepherd on 11/27/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import UIKit

@IBDesignable
class Faceview: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.90
    @IBInspectable
    var mouthCurvature: Double = 1.0
    @IBInspectable
    var eyesOpen: Bool = true
    @IBInspectable
    var eyeBrowTilt: Double = 0.0
    @IBInspectable
    var color: UIColor = UIColor.blue
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    
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
        static let headToBrowOffset: CGFloat = 5
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
        
        if eyesOpen{
            return pathForCircleCenterAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
            
        } else{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius,y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
            
        }
    }
    
    private func pathForCircleCenterAtPoint(midPoint:CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius, startAngle: 0.0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: false
        )
        path.lineWidth = lineWidth
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
        
        
        let smileOffset = CGFloat(max(-1,min(mouthCurvature, 1))) * mouthRect.height
        let startPoint = CGPoint(x: mouthRect.minX,y: mouthRect.minY)
        let endPoint =  CGPoint(x: mouthRect.maxX,y: mouthRect.minY)
        let cp1 = CGPoint(x:mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset )
        let cp2 = CGPoint(x:mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset )
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    
    private func pathForBrow(eye:Eye)-> UIBezierPath{
        var tilt = eyeBrowTilt
        switch eye{
        case .Left: tilt *= -1.0
        case .Right: break
            
        }
        var browCenter = getEyeCenter(eye: eye)
        browCenter.y -= headRadius / Ratios.headToBrowOffset
        let eyeRadius = headRadius / Ratios.headToEyeRadius
        let tiltOffset = CGFloat(max(-1,min(tilt,1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd =  CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
        
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
        
        color.set()
        pathForCircleCenterAtPoint(midPoint: headCenter, withRadius: headRadius).stroke()
        pathforEye(eye: .Left).stroke()
        pathforEye(eye: .Right).stroke()
        pathForMouth().stroke()
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }
    
    
}
