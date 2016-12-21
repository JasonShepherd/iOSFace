//
//  ViewController.swift
//  Faceit
//
//  Created by Jason Shepherd on 11/27/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile){
        didSet{
            updateUI()
        }
    }
    // to face
    @IBOutlet weak var faceView: Faceview!{
        didSet{ updateUI()
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(Faceview.changeScale(recognizer:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness))
            
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            updateUI()
            
        }
    }
    
    
    func increaseHappiness(){
        expression.mouth = expression.happierMouth()
    }
    private  var mouthCurvatures=[FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0,.Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    private func updateUI(){
        
        switch expression.eyes{
        case .Open : faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}

