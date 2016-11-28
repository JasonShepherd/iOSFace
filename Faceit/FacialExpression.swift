//
//  FacialExpression.swift
//  Faceit
//
//  Created by Jason Shepherd on 11/28/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import Foundation

struct FacialExpression{
    
    enum Eyes: Int{
        case Open
        case closed
        case Squinting
    }
    
    enum EyeBrows: Int{
        case Relaxed
        case Normal
        case Furrowed
    }
    
    func moreRelaxedBrow() ->EyeBrows {
        return EyeBrows(rawValue: -1) ?? .Relaxed
    }
    
    
    func moreFurrowedBrow() ->EyeBrows {
        return EyeBrows(rawValue: +1) ?? .Furrowed
    }
    
    
    enum Mouth: Int{
        case Frown
        case Smirk
        case Neutral
        case Grin
        case mile
        
    }
    func sadderMouth() ->Mouth{
        return Mouth(rawValue: -1) ?? .Frown
        
    }
    
    func happierMouth() ->Mouth{
        return Mouth(rawValue: +1) ?? .Grin
        
    }
    
    
    var eyes: Eyes
    var eyeBrows: EyeBrows
    var mouth: Mouth
    
    
    
}
