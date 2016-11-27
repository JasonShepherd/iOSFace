//
//  Faceview.swift
//  Faceit
//
//  Created by Jason Shepherd on 11/27/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import UIKit

class Faceview: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
       
        
        let headRadius = min(bounds.size.width,bounds.size.height) / 2
        let headCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        
        let head = UIBezierPath(arcCenter: headCenter, radius: headRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        
        head.lineWidth = 5.0
        UIColor.blue.set()
        head.stroke()
    }
 

}
