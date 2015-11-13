//
//  ViewController.swift
//  FileSystem
//
//  Created by Usuário Convidado on 11/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("bgColor") == nil) {
            NSUserDefaults.standardUserDefaults().setValue("S", forKey: "bgColor")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        let isBgAzul = (NSUserDefaults.standardUserDefaults().objectForKey("bgColor") as! String == "S")
        self.view.backgroundColor = isBgAzul ? UIColor.blueColor() : UIColor.redColor()
        
        if(isBgAzul) {
            NSUserDefaults.standardUserDefaults().setValue("N", forKey: "bgColor")
        } else {
            NSUserDefaults.standardUserDefaults().setValue("S", forKey: "bgColor")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        /* LENDO DE PLIST
        if let plistPath = NSBundle.mainBundle().pathForResource("ExemploPropertyList", ofType: "plist") {
            let array = NSArray(contentsOfFile: plistPath)
            for dic in array! {
                let nome = dic["Nome"]!
                let valor = dic["Valor"]!
                print(nome!)
                print(valor!)
            }
        }
        */
       
        /* MANIPULANDO ARQUIVOS
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath = path[0]
        
        let textFilePath = ("\(docPath)/myfile.txt")
        let texto = "Este é o conteúdo do arquivo"
        let data = texto.dataUsingEncoding(NSUTF8StringEncoding)!
        
        NSFileManager.defaultManager().createFileAtPath(textFilePath, contents: data, attributes: nil)
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

