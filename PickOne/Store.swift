//
//  Store.swift
//  PickOne
//
//  Created by Admin on 10/14/16.
//  Copyright © 2016 VS. All rights reserved.
//

class Store {
    var lat : Double!
    var long : Double!
    var distance:String!
    var destination:String!
    var duration:String!
    
    init(lat : Double,long:Double,distance:String,destination:String!,duration:String!){
        self.lat = lat
        self.long = long
        self.distance = distance
        self.destination = destination
        self.duration = duration
    }
}
