//
//  ViewController.swift
//  Animation
//
//  Created by Usuário Convidado on 16/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.animationImages = []
        for(var count = 1; count <= 8; count++) {
            img.animationImages?.append(UIImage(named: "sonic" + "\(count)")!)
        }
        img.animationDuration = NSTimeInterval(0.2)
        img.animationRepeatCount = 0
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saltarTap(sender: UIButton) {
        
        UIView.animateWithDuration(NSTimeInterval(1), animations: { () -> Void in
            self.img.center = CGPointMake(self.img.center.x, self.img.center.y - 100)
            }) { (completion) -> Void in
                UIView.animateWithDuration(NSTimeInterval(1), animations: { () -> Void in
                      self.img.center = CGPointMake(self.img.center.x, self.img.center.y + 100)
                })
              
        }
    
    }
    
    @IBAction func tapGirar(sender: UIButton) {
        let angle:CGFloat = (180.0 * CGFloat(M_PI)) / 180.0
        UIView.animateWithDuration(NSTimeInterval(0.2), animations: { () -> Void in
            self.img.transform = CGAffineTransformMakeRotation(angle)
            }) { (completion) -> Void in
                UIView.animateWithDuration(NSTimeInterval(0.3), animations: { () -> Void in
                    self.img.transform = CGAffineTransformMakeRotation(angle * 2)
                })
                
        }

    }

    @IBAction func tapCorrer(sender: UIButton) {
        if(img.isAnimating()) {
            sender.setTitle("Correr", forState: UIControlState.Normal)
            img.stopAnimating()
        } else {
            sender.setTitle("Parar", forState: UIControlState.Normal)
            img.startAnimating()
        }
    }
}

