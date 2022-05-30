//
//  BikeRoadViewController.swift
//  Bikemate
//
//

import UIKit
import CoreLocation
import NMapsMap

class BikeRoadViewController: UIViewController, CLLocationManagerDelegate {

    
    private var locationManager: CLLocationManager!
    var mapView: NMFMapView!
    var naverMapView: NMFNaverMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationPermission()

        mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)

        setMapViewLoctaionDefault()
        
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = false
        
        locationOverlay.location = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 37.5670135, lng: locationManager.location?.coordinate.longitude ?? 126.9783740)
        locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
        
        
        mapView.positionMode = .normal
        locationOverlay.circleRadius = 50
        
        mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: true)     
    }

    
    // 현재 위치로 시점 이동
    private func setMapViewLoctaionDefault() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    private func setLocationPermission() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         switch status {
         case .authorizedAlways, .authorizedWhenInUse:
             print("GPS 권한 설정됨")
             self.locationManager.startUpdatingLocation()
         case .restricted, .notDetermined:
             print("GPS 권한 설정되지 않음")
             getLocationUsagePermission()
         case .denied:
             print("GPS 권한 요청 거부됨")
             getLocationUsagePermission()
         default:
             print("GPS: Default")
         }
    }
}
