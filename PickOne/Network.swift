//
//  Network.swift
//  PickOne
//
//  Created by Admin on 10/14/16.
//  Copyright © 2016 VS. All rights reserved.
//

import Alamofire

class Network {
    
    static let shareInstace = Network()
    
    
    let findNearbyAPI = "https://androidteamstore.herokuapp.com/api/store/findNearby"
    //let findNearbyAPI = "http://10.64.1.159:1337/api/store/findNearby"
    
    func findNearby(lat: String,long: String,keyword:String,callback: ()->Void){
        
        var latX : Double!
        var longX : Double!
        var destinationX : String!
        var distanceX : String!
        var durationX : String!
        ListStore.list.removeAll()
        
        let params = [
            "lat": lat,
            "long": long,
            "menu": keyword
        ]
        Alamofire.request(.POST, findNearbyAPI, parameters: params  , encoding : .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                //print("result: \(response.result.value)")
                
                if response.result.value != nil {
                    if let JSON = response.result.value {
                        if let asd = JSON["value"]{
                            print(JSON)
                            if let ad = asd {
                                for i in 0...ad.count-1 {
                                    if let lat = ad[i]["lat"]!{
                                        
                                        latX = lat as! Double
                                    }
                                    if let long = ad[i]["long"]!{
                                        longX = long as! Double
                                    }
                                    
                                    if let distance = ad[i]["distance"]!{
                                        distanceX = distance as! String
                                    }
                                    if let destination = ad[i]["destination"]!{
                                        destinationX = destination as! String
                                    }
                                    if let duration = ad[i]["duration"]!{
                                        durationX = duration as! String
                                    }
                                    let store = Store.init(lat: latX, long: longX, distance: distanceX, destination: destinationX,duration: durationX)
                                    ListStore.list.append(store)
                                    
                                }
                                callback()
                                for i in 0...ListStore.list.count-1{
                                    print(ListStore.list[i].distance)
                                }
                                
                            }
                            
                        }
                    }
                }

        }
    }
    
    func findNearby(lat: String,long: String,callback:()->Void){
        ListStore.list.removeAll()
        
        var latX : Double!
        var longX : Double!
        var destinationX : String!
        var distanceX : String!
        var durationX :String!
        
        let params = [
            "lat": lat,
            "long": long
        ]
        Alamofire.request(.POST, findNearbyAPI, parameters: params , encoding : .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                //print("result: \(response.result.value)")
                
                if response.result.value != nil {
                    if let JSON = response.result.value {
                        if let asd = JSON["value"]{
                            print(JSON)
                            if let ad = asd {
                                for i in 0...ad.count-1 {
                                    if let lat = ad[i]["lat"]!{
                                        print(lat)
                                        latX = lat as! Double
                                    }
                                    if let long = ad[i]["long"]!{
                                        longX = long as! Double
                                    }
                                    
                                    if let distance = ad[i]["distance"]!{
                                        distanceX = distance as! String
                                    }
                                    if let destination = ad[i]["destination"]!{
                                        destinationX = destination as! String
                                    }
                                    if let duration = ad[i]["duration"]!{
                                        durationX = duration as! String
                                    }
                                    
                                    let store = Store.init(lat: latX, long: longX, distance: distanceX, destination: destinationX,duration: durationX)
                                    ListStore.list.append(store)
                                }
                                print(ListStore.list[1].distance)
                            }
                            
                        }
                    }
                }
        }
    }
}



