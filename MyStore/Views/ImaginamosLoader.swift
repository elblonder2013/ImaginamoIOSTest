//
//  ImaginamosLoader.swift
//  IpadMyStore
//
//  Created by Alexei on 15/03/2017.
//  Copyright © 2017 Alexei. All rights reserved.
//

import UIKit

class ImaginamosLoader: UIView {

    var circle1: UIImageView!
    var circle2: UIImageView!
    var isLoading: Bool!
    func InicarComponentes()
    {
        isLoading = true
        circle1 = (self.subviews.last! as UIView).subviews[1] as! UIImageView;
        circle2 = (self.subviews.last! as UIView).subviews[2] as! UIImageView;
      
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2 * M_PI
        rotationAnimation.repeatCount = HUGE
        rotationAnimation.duration = 1.5
        
        
        let rotationAnimation2 = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation2.fromValue = 0.0
        rotationAnimation2.toValue = 2 * M_PI
        rotationAnimation2.repeatCount = HUGE
        rotationAnimation2.duration = 0.5

        circle1.layer.add(rotationAnimation, forKey: nil)
        circle2.layer.add(rotationAnimation2, forKey: nil)
        IniciarAnimaciones(opacity: true,view:circle1,time:1.5)
        IniciarAnimaciones(opacity: false,view:circle2,time:0.5)
        
        
    }
    func IniciarAnimaciones(opacity:Bool,view:UIView,time:TimeInterval)
    {
        
       UIView.animate(withDuration: time, animations: { () -> Void in
            
        if(opacity)
        {
            view.alpha = 0.1
        }
        else
        {
             view.alpha = 0.9
        }
            
        }, completion: { (finished: Bool) -> Void in
            if(self.isLoading==true){
                self.IniciarAnimaciones(opacity: !opacity, view: view, time:time)
            }
           
        })
    }
    func DetenerAnimaciones()
    {
        circle2.layer.removeAllAnimations()
        circle1.layer.removeAllAnimations()
        isLoading = false
    }

}
