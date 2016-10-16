//
//  MenuViewController.swift
//  PickOne
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 VS. All rights reserved.
//

import UIKit
import QuartzCore
import GoogleMaps
class MenuViewController: UIViewController ,CLLocationManagerDelegate{
    @IBOutlet weak var fixingBtn: UIButton!

    @IBOutlet weak var computerButton: UIButton!
    @IBOutlet weak var suaXeButton: UIButton!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        fixingBtn.layer.cornerRadius = 10
        fixingBtn.layer.borderWidth = 4.0
        fixingBtn.layer.borderColor = UIColor.grayColor().CGColor
        computerButton.layer.cornerRadius = 10
        computerButton.layer.borderWidth = 4.0
        computerButton.layer.borderColor = UIColor.grayColor().CGColor
        suaXeButton.layer.cornerRadius = 10
        suaXeButton.layer.borderWidth = 4.0
        suaXeButton.layer.borderColor = UIColor.grayColor().CGColor
        mobileButton.layer.cornerRadius = 10
        mobileButton.layer.borderWidth = 4.0
        mobileButton.layer.borderColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func suaxeButtonDidtap(sender: AnyObject) {
        Network.shareInstace.findNearby(String((locationManager.location?.coordinate.latitude)!), long: String((locationManager.location?.coordinate.longitude)!), keyword: "sua chua xe may",callback: {
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            
            self.navigationController?.pushViewController(secondViewController, animated: true)

        })
        print((locationManager.location?.coordinate.latitude)!)
        print((locationManager.location?.coordinate.longitude)!)
    }

    @IBAction func mobileButtonDidTap(sender: AnyObject) {
        Network.shareInstace.findNearby(String((locationManager.location?.coordinate.latitude)!), long: String((locationManager.location?.coordinate.longitude)!), keyword: "sua chua dien thoai",callback: {
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        print((locationManager.location?.coordinate.latitude)!)
        print((locationManager.location?.coordinate.longitude)!)
    }

    @IBAction func computerButtonDidTap(sender: AnyObject) {
        Network.shareInstace.findNearby(String((locationManager.location?.coordinate.latitude)!), long: String((locationManager.location?.coordinate.longitude)!), keyword: "sua chua may tinh",callback: {
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        print((locationManager.location?.coordinate.latitude)!)
        print((locationManager.location?.coordinate.longitude)!)
        

    }
    
    @IBAction func fixButtonDidTap(sender: AnyObject){
        Network.shareInstace.findNearby(String((locationManager.location?.coordinate.latitude)!), long: String((locationManager.location?.coordinate.longitude)!), keyword: "sua chua dien",callback: {
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        print((locationManager.location?.coordinate.latitude)!)
        print((locationManager.location?.coordinate.longitude)!)
    }

}
