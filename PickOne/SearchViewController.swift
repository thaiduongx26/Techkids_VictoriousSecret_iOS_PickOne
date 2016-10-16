//
//  SearchViewController.swift
//  PickOne
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 VS. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class SearchViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    @IBOutlet weak var viewMap: GMSMapView!

    @IBOutlet weak var searchTableView: UITableView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        print("my location : \(locationManager.location?.coordinate)")
        viewMap.myLocationEnabled = true
        print(locationManager.location?.coordinate.latitude)
//        let camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude
//            )!,longitude:(locationManager.location?.coordinate.longitude)!, zoom:10)
//        viewMap.camera = camera
        viewMap.settings.compassButton = true
        viewMap.settings.myLocationButton = true
        
        let path = GMSMutablePath()
        path.addCoordinate(CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))
        for i in 0...ListStore.list.count-1{
            createMaker(ListStore.list[i].lat, long: ListStore.list[i].long, address: ListStore.list[i].destination)
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        createDirection(ListStore.list[indexPath.row].lat, long: ListStore.list[indexPath.row].long)
        print(1)
    }
    func createMaker(lat:Double,long:Double,address:String){
        let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: long, zoom: 14)
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = address
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = viewMap
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK : tableView datasource and delegate
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ListStore.list.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = searchTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! searchTableViewCell
        cell.lblAddress.text = ListStore.list[indexPath.row].destination
        cell.lblDistance.text = ListStore.list[indexPath.row].distance
        cell.lblDuration.text = ListStore.list[indexPath.row].duration
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            viewMap.myLocationEnabled = true
            viewMap.settings.myLocationButton = true
            
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            viewMap.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            print(locationManager.location?.coordinate)
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func createDirection(lat : Double , long: Double) {
        
        let api = "https://maps.googleapis.com/maps/api/directions/json?origin=\((locationManager.location?.coordinate.latitude)!),\((locationManager.location?.coordinate.longitude)!)&destination=\(lat),\(long)&key=AIzaSyDK7QMuayz2ahr_xJZjrcHyv-5mGGc7SbI"
        self.viewMap.clear()
        Alamofire.request(.POST, api)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                //print("result: \(response.result.value)")
                
                if response.result.value != nil {
                    if let JSON = response.result.value {
                        if let path = JSON["routes"]!![0]!["overview_polyline"]!!["points"]!{
                            print(path)
                            let path1 = GMSPath.init(fromEncodedPath: path as! String)
                            let rectangle = GMSPolyline(path: path1!)
                            rectangle.strokeWidth = 7
                            rectangle.strokeColor = UIColor.blueColor()
                            rectangle.map = self.viewMap
                        }
                    }
                }
        }
    }
}
