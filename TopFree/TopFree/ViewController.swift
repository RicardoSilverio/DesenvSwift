//
//  ViewController.swift
//  TopFree
//
//  Created by Usuário Convidado on 07/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgIcone: UIImageView!
    @IBOutlet weak var lblNome: UILabel!
    
    var session:NSURLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig)
        
        let url = NSURL(string: "http://itunes.apple.com/br/rss/topfreeapplications/limit=1/json")
        let task = session!.dataTaskWithURL(url!) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if(error != nil) {
                print("Deu erro!")
            } else {
                let retornoRequest = self.getTopFreeApp(data)
                if let imgUrl = retornoRequest.imgUrl {
                    self.downloadImage(imgUrl)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.lblNome.text = retornoRequest.name
                })

            }
        }
        
        task.resume()
        
    }
    
    func getTopFreeApp(data:NSData?) -> (name: String?, imgUrl:String?) {
        var returnName:String?
        var returnImageUrl:String?
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if let feed = json["feed"] as? [String:AnyObject] {
                if let entry = feed["entry"] as? [String:AnyObject] {
                    if let name = entry["im:name"] as? [String:AnyObject] {
                        if let label = name["label"] as? String {
                            returnName = label
                        }
                    }
                    if let images = entry["im:image"] as? [[String:AnyObject]] {
                        if let urlImage = images[images.count - 1]["label"] as? String {
                            returnImageUrl = urlImage
                        }
                    }
                }
            }
        } catch {
            print("Erro no parse do JSON")
        }
        return (returnName, returnImageUrl)
    }
    
    func downloadImage(imgURL:String) -> Void {
        let urlImg = NSURL(string: imgURL)
        let imageSession = NSURLSession.sharedSession()
        let imgTask = imageSession.downloadTaskWithURL(urlImg!) { (url, response, error) -> Void in
            if(error != nil) {
                print("Deu erro na requisição da imagem")
            } else {
                if let imageData = NSData(contentsOfURL: url!) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.imgIcone.image = UIImage(data: imageData)
                    })
                } else {
                    print("Não carregou imagem")
                }
            }
        }
        imgTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

