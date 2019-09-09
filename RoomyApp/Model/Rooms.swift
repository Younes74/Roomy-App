//
//  Rooms.swift
//  RoomyApp
//
//  Created by MAC on 9/5/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import Foundation

struct Rooms: Codable {
    var id: Int?
    var title, price, place: String?
    var image: String?
    var description: String?
    
    init(id:Int,title:String,price:String,place:String,image:String,description:String) {
        self.id = id
        self.title = title
        self.price = price
        self.place = place
        self.image = image
        self.description = description
    }
   
}

