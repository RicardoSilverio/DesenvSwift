//
//  RSSMapaViewController.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class RSSMapaViewController: UIViewController, MKMapViewDelegate {
    
    var managedObjectContext:NSManagedObjectContext?
    var locaisVO:[RSSLocalVO] = []
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()

    var session:NSURLSession?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        
        let pontoInicial:CLLocationCoordinate2D = CLLocationCoordinate2DMake(-23.550303, -46.634184)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(pontoInicial, 12000, 12000)
        
        self.managedObjectContext = Setup.getManagedObjectContext()
        loadPontosTuristicos()
    }
    
    func loadPontosTuristicos() {
        
        let entityDescription = NSEntityDescription.entityForName("Local", inManagedObjectContext: self.managedObjectContext!)
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("carga") == nil) {
        
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            session = NSURLSession(configuration: sessionConfig)
        
            let task = session?.dataTaskWithURL(NSURL(string: "http://flameworks.com.br/fiap/pontosTuristicos.txt")!,
                completionHandler: { (data, response, error) -> Void in
                    do {
                        if(error != nil) {
                            print("Erro na requisição")
                        }
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        let locais = json["locais"] as! [[String:AnyObject]]
                        for local in locais {
                            let coordenadas = local["coordenadas"] as! [String:AnyObject]
                            let vo:RSSLocalVO = RSSLocalVO(nome: local["nome"] as! String, endereco: local["endereco"] as! String, imagem: local["imagem"] as! String, lat: coordenadas["lat"] as! Double,    long: coordenadas["lon"] as! Double)
                            self.locaisVO.append(vo)
                            self.addLocalAnnotation(vo)
                        }
                        
                        
                         do {
                            for vo in self.locaisVO {
                                let local = Local(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
                                local.nome = vo.nome
                                local.endereco = vo.endereco
                                local.imagem = vo.imagem
                                local.lat = vo.lat
                                local.long = vo.long
                           
                                try self.managedObjectContext?.save()

                            }
                        
                            NSUserDefaults.standardUserDefaults().setValue("S", forKey: "carga")
                            NSUserDefaults.standardUserDefaults().synchronize()
                        } catch {
                            print("Erro ao salvar local no banco")
                        }
                    
                    } catch {
                        print("Erro na serialização do JSON")
                    }
            })
            task?.resume()
            
        } else {
            
            let fetchRequest = NSFetchRequest(entityName: "Local")
            let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                let results = try managedObjectContext!.executeFetchRequest(fetchRequest)
                for item in results {
                    let local = item as! Local
                    let vo:RSSLocalVO = RSSLocalVO(nome: local.nome!, endereco: local.endereco!, imagem: local.imagem!, lat: Double(local.lat!), long: Double(local.long!))
                    addLocalAnnotation(vo)
                }
            } catch {
                print("Erro ao consultar locais no banco")
            }
            
        }
        
    }
    
    func addLocalAnnotation(vo:RSSLocalVO) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView.addAnnotation(RSSLocalAnnotation(coordinate: CLLocationCoordinate2D(latitude: vo.lat!, longitude: vo.long!), title: vo.nome!, subtitle: vo.endereco!, stringURLImagem: vo.imagem!))
        })
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! RSSLocalAnnotation
        performSegueWithIdentifier("mapaToDetailSegue", sender: annotation)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! RSSDetalheViewController
        let annotation = sender as! RSSLocalAnnotation
        detailViewController.nome = annotation.title
        detailViewController.endereco = annotation.subtitle
        detailViewController.stringURLImagem = annotation.stringURLImagem
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is RSSLocalAnnotation) {
            let reuseId = "reusePonto"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if(anView == nil){
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "bluePin")
                anView!.canShowCallout = true
                anView?.rightCalloutAccessoryView = UIButton(type: .InfoLight)
            }
            return anView

        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
