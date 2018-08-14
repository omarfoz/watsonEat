//
//  google.swift
//  VirtualAssistantforiOSSideProject
//
//  Created by Omar Yahya Alfawzan on 7/31/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces



class NearByObject {
    
    var Latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    var name : String!
    var Address : String!
    var icon : String!
    var rate : Float!
    var place_id: String!
    
    func updateInfo(NearBy : NearByObject){
        
        self.Latitude = NearBy.Latitude
        self.longitude = NearBy.longitude
        self.name = NearBy.name
        self.Address = NearBy.Address
        self.icon = NearBy.icon
        self.rate = NearBy.rate
        self.place_id = NearBy.place_id
    }
    
    func setLati(Lati : CLLocationDegrees){
        self.Latitude = Lati
    }
    
    func SetLong(Long : CLLocationDegrees) {
        self.longitude = Long
        
    }
    
    
    

    
}




extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}









