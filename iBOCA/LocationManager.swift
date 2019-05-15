//
//  LocationManager.swift
//  iBOCA
//
//  Created by Dat Huynh on 4/22/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private var locationManager: CLLocationManager!
    var lastKnownCoordinate: CLLocationCoordinate2D
    var viewController: UIViewController?
    var isLocationNotDetermined: Bool = false
    var currentState: String = ""
    
    private override init() {
        lastKnownCoordinate = kCLLocationCoordinate2DInvalid
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func requestLocationServiceIfNeeded(in viewController: UIViewController) {
        self.viewController = viewController
        
        if !isLocationServiceAvailable() {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startLocationService() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopLocationService() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func isLocationServiceAvailable() -> Bool {
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            return true
        }
        return false
    }
    
    func isLocationServiceNotEnable() -> Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            self.startLocationService()
        } else if (status == .notDetermined) {//In case of notDetermined -> Just start normally
            isLocationNotDetermined = true
        } else { // Location service disabled -> Display alert
            
            // Show alert first time init
            if isLocationNotDetermined {
                isLocationNotDetermined = false
                
                let alertController = UIAlertController.init(title: "", message: "Please turn on location permission to do this test.", preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (_) in
                    self.viewController?.dismiss(animated: true, completion: nil)
                }
                let okAction = UIAlertAction.init(title: "OK", style: .default) { (_) in
                    if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
                        UIApplication.shared.openURL(url)
                    }
                    
                    self.viewController?.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                DispatchQueue.main.async {
                    self.viewController?.present(alertController, animated: true, completion: nil)
                }

            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.lastKnownCoordinate = location.coordinate
            if location.coordinate.latitude != -180 && location.coordinate.longitude != -180 {
                CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMarks, error) in
                    if let state = placeMarks?.last?.locality, !state.isEmpty {
                        self.currentState = state
                        self.stopLocationService()
                    }
                }
                
            }
        }
    }
}
