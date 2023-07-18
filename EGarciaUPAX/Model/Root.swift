//
//  Data.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 17/07/23.
//

import Foundation
struct Root: Codable {
    var data : [data] = []
    
}
struct data: Codable {
    
   
    var pregunta : String?
    var values : [Values]? = []
    
}

struct Values: Codable {
    var label :  String?
    var value :  Int?
}
