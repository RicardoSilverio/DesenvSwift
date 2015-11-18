//
//  TopFreeTableViewController.swift
//  Top10Free
//
//  Created by Ricardo Silverio de Souza on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class TopFreeTableViewController: UITableViewController {
    
    var session:NSURLSession?
    var top10:NSMutableDictionary = NSMutableDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfig)
        
        let url = NSURL(string: "https://itunes.apple.com/br/rss/topfreeapplications/limit=10/json")
        let task = self.session?.dataTaskWithURL(url!, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if(error != nil) {
                print("Erro na requisição do json")
            } else {
                self.getTop10Free(data!)
            }
        })
        task?.resume()
        
    }
    
    func getTop10Free(data:NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let feed = json["feed"] as? [String:AnyObject] {
                if let entry = feed["entry"] as? [[String:AnyObject]] {
                    var posicao = 0
                    for app in entry {
                        var cell:NSMutableDictionary = NSMutableDictionary()
                        if let imName = app["im:name"] as? [String:AnyObject] {
                            if let label = imName["label"] as? String {
                                cell["nome"] = label
                                cell["posicao"] = posicao++
                                if let imImage = app["im:image"] as? [[String:AnyObject]] {
                                    let firstImage = imImage[0]
                                    if let stringURLImage = firstImage["label"] as? String {
                                        let urlImage:NSURL = NSURL(string: stringURLImage)!
                                        loadImage(urlImage, cell: cell)
                                    }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
        } catch {
            print("Erro na serialização do json")
        }
    }
    
    func loadImage(urlImage:NSURL, cell:NSMutableDictionary) {
        let imageSession = NSURLSession.sharedSession()
        let task = imageSession.downloadTaskWithURL(urlImage, completionHandler: { (urlResponse, response, error) -> Void in
            if(error != nil) {
                print("Erro na requisição da imagem")
            } else {
                if let imageData = NSData(contentsOfURL: urlResponse!) {
                    cell["imagem"] = UIImage(data: imageData)
                    self.top10["\(cell["posicao"]!)"] = cell
                    if(self.isRankingFullyLoaded()) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        })
        task.resume()
    }
    
    func isRankingFullyLoaded() -> Bool {
        return top10.count == 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return top10.count > 0 ? 1 : 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top10.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellApp", forIndexPath: indexPath)
        let app = top10["\(indexPath.row)"]
        cell.textLabel?.text = (app!["nome"] as! String)
        cell.imageView?.image = (app!["imagem"] as! UIImage)
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
