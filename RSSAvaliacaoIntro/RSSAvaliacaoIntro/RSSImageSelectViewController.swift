//
//  RSSImageSelectViewController.swift
//  RSSAvaliacaoIntro
//
//  Created by Usuário Convidado on 04/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

protocol RSSImageSelectViewControllerDelegate {
    
    func fruitIsSelected(fruitName:String)
    
}

class RSSImageSelectViewController: UIViewController {
    
    var delegate:RSSImageSelectViewControllerDelegate?
    let arrayFruits:[String] = ["abacaxi", "banana", "cereja", "kiwi", "laranja", "limao", "manga", "uva"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count: Int = 0
        var lastX: Int = 25
        var lastY: Int = 25
        
        for fruta:String in arrayFruits {
            count++
            if(count%3 == 1) {
                lastX = 25
                lastY += 100
            }
            let button: UIButton = UIButton(frame: CGRect(x: lastX, y: lastY, width: 75, height: 75))
            lastX += 100
            
            button.setImage(UIImage(named: fruta), forState: UIControlState.Normal)
            button.tag = count - 1
            button.addTarget(self, action: "tapFruitButton:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            
        }
        
    }
    
    func tapFruitButton(sender:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.fruitIsSelected(arrayFruits[sender.tag])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
