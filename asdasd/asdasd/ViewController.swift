//
//  ViewController.swift
//  asdasd
//
//  Created by Usuário Convidado on 09/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        let fiapRegion:CLLocationCoordinate2D = CLLocationCoordinate2DMake(-23.573928, -46.623272)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(fiapRegion, 3500, 3500)
        
        let marianaLocation:MetroAnnotation = MetroAnnotation(coordinate: CLLocationCoordinate2DMake(-23.589541, -46.634701), title: "Metrô Vila Mariana", subtitle: "Estação de Metrô da Linha 1 - Azul")
        /*
        let marianaLocation:MKPointAnnotation = MKPointAnnotation()
        marianaLocation.coordinate = CLLocationCoordinate2DMake(-23.589541, -46.634701)
        marianaLocation.title = "Metrô Vila Mariana"
        marianaLocation.subtitle = "Estação de Metrô da Linha 1 - Azul"
        */
        mapView.addAnnotation(marianaLocation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MetroAnnotation) {
            let reuseId = "reuseMetroAnnotation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if(anView == nil) {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "metroLogo")
                anView!.canShowCallout = true
                anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            }
            return anView
        } else if(annotation is MKUserLocation) {
            let reuseId = "reuseMyLocation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if(anView == nil){
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "userLogo")
                anView!.canShowCallout = false
            }
            return anView
        } else {
            let reuseId = "reuseLocalAnnotation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if(anView == nil) {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "interesseLogo")
                anView!.canShowCallout = true
                //let button = UIButton(type: UIButtonType.DetailDisclosure)
                anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            }
            return anView
        }
        return nil
    }
    
    func displayRegionCenteredOnMapItem(from:MKMapItem) {
        
        let fromLocation: CLLocation = from.placemark.location!
        let region = MKCoordinateRegionMakeWithDistance(fromLocation.coordinate, 10000, 10000)
        let opts =
        [
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan:region.span),
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate:region.center)
        ]
        from.openInMapsWithLaunchOptions(opts)
        
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let request:MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = mapView.region
        var search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) -> Void in
            if(error == nil) {
                var placemarks:[MKAnnotation] = []
                for item:MKMapItem in response!.mapItems {
                    let place = LocalAnnotation(coordinate: item.placemark.coordinate, title: item.name!, subtitle: "", item: item)
                    placemarks.append(place)
                }
                for ann:MKAnnotation in self.mapView.annotations {
                    if(!(ann is MetroAnnotation)) {
                        self.mapView.removeAnnotation(ann)
                    }
                }
                self.mapView.addAnnotations(placemarks)
                searchBar.resignFirstResponder()
            } else {
                print("Deu erro na busca de pontos de interesse")
            }
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if(view.annotation is MetroAnnotation) {
            let url:NSURL = NSURL(string: "http:/www.metro.sp.gov.br")!
            UIApplication.sharedApplication().openURL(url)
        } else if(view.annotation is LocalAnnotation) {
            displayRegionCenteredOnMapItem((view.annotation as! LocalAnnotation).item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segValueChanged(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
            case 0:
                mapView.mapType = MKMapType.Standard
            case 1:
                mapView.mapType = MKMapType.Satellite
            case 2:
                mapView.mapType = MKMapType.Hybrid
            default:
                mapView.mapType = MKMapType.Standard
            
        }
    }

}

