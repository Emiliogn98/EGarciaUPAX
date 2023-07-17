//
//  Data.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 17/07/23.
//

import Foundation
struct Root: Codable {
    var data : [Data] = []
    
}
struct Data: Codable {
    
   
    var pregunta : String?
    var values : [Values]? = []
    
}

struct Values: Codable {
    var label :  String?
    var value :  Int?
}
