//
//  ViewController.swift
//  CubeMotion
//
//  Created by Sebastien ALIBERT on 4/2/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dynamicAnimator: UIDynamicAnimator?
    let gravityBehavior = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()
    let elasticityBehavior = UIDynamicItemBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.magnitude = 2
        elasticityBehavior.elasticity = 0.6
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator?.addBehavior(gravityBehavior)
        dynamicAnimator?.addBehavior(collisionBehavior)
        dynamicAnimator?.addBehavior(elasticityBehavior)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedGesture(gesture:))))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func drawGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.gravityBehavior.removeItem(gesture.view!)
        case .changed:
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            self.dynamicAnimator?.updateItem(usingCurrentState: gesture.view!)
        case .ended:
            self.gravityBehavior.addItem(gesture.view!)
        default:
            break
        }
    }
    
    @objc func rotateGesture(gesture: UIRotationGestureRecognizer) {
        if let scopeView = gesture.view as? geoShape {
            switch gesture.state {
            case .began:
                view.bringSubview(toFront: scopeView)
                self.gravityBehavior.removeItem(scopeView)
            case .changed:
                self.collisionBehavior.removeItem(scopeView)
                self.elasticityBehavior.removeItem(scopeView)
                scopeView.transform = view.transform.rotated(by: gesture.rotation)
                self.dynamicAnimator?.updateItem(usingCurrentState: gesture.view!)
                self.elasticityBehavior.addItem(scopeView)
                self.collisionBehavior.addItem(scopeView)
            case .ended:
                self.gravityBehavior.addItem(gesture.view!)
            default:
                break
            }
        }
    }

    @objc func pinchGesture(gesture: UIPinchGestureRecognizer) {
        if let scopeView = gesture.view as? geoShape {
            switch gesture.state {
            case .began:
                self.gravityBehavior.removeItem(scopeView)
            case .changed:
                self.collisionBehavior.removeItem(scopeView);
                self.elasticityBehavior.removeItem(scopeView);
                if (scopeView.bounds.size.width * gesture.scale < view.bounds.size.width) && (scopeView.bounds.size.width * gesture.scale > 25) {
                    scopeView.bounds.size.width *= gesture.scale
                    scopeView.bounds.size.height *= gesture.scale
                    if (scopeView.layer.cornerRadius != 0) {
                        gesture.view!.layer.cornerRadius *= gesture.scale
                    }
                }
                gesture.scale = 1
                self.collisionBehavior.addItem(scopeView)
                self.elasticityBehavior.addItem(scopeView)
                self.dynamicAnimator?.updateItem(usingCurrentState: view);
            case .ended:
                self.gravityBehavior.addItem(gesture.view!)
            default:
                break
            }
        }
    }
    
    @objc func tappedGesture(gesture: UITapGestureRecognizer) {
        let gestureLocation = gesture.location(in: self.view)
        let newShape = geoShape(xPos: gestureLocation.x - 50, yPos: gestureLocation.y - 50)
        view.addSubview(newShape)
        gravityBehavior.addItem(newShape)
        collisionBehavior.addItem(newShape)
        elasticityBehavior.addItem(newShape)
        newShape.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(gesture:))))
        newShape.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(drawGesture(gesture:))))
        newShape.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotateGesture(gesture:))))
    }
}
