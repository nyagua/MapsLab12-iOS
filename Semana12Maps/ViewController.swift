//
//  ViewController.swift
//  Semana12Maps
//
//  Created by mbtec22 on 6/17/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var pintAnnotation: CustomPointAnnotation?
    var pointAnnotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocation()
        setUpMap()
        addAnnotations(coords: getCoordinates())
    }
    
    // Como controlar el mapa
    func setUpMap() {
        //Tipo de mapa
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }

    @IBAction func actionSegmentControl(_ sender: Any) {
        // 0, 1, 2, 3
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        case 3:
            mapView.mapType = .hybridFlyover
        default:
            break
        }
        
    }
    
    func getCoordinates() -> [CLLocation]{
        return [
            CLLocation(latitude: -12.0447773, longitude: -76.9544714),
            CLLocation(latitude: -12.0464746, longitude: -12.0464746),
            CLLocation(latitude: -12.0455686, longitude: -76.9564661),
            CLLocation(latitude: -12.0454803, longitude: -76.950959),
        ]
        
    }
 
    func addAnnotations(coords: [CLLocation]) {
        for coord in coords {
            let CLLCoordType = CLLocationCoordinate2D(
                latitude: coord.coordinate.latitude,
                longitude: coord.coordinate.longitude
            );
            let annotation = CustomPointAnnotation()
            annotation.coordinate = CLLCoordType
            annotation.pinCustomImage = "marker"
            annotation.title = "Ubicacion"
            annotation.subtitle = "Subtitulo"
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {}

extension ViewController: MKMapViewDelegate {}
