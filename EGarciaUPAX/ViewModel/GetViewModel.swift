//
//  GetViewModel.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 14/07/23.
//

import Foundation

class GetViewModel{

    
    
    static func Get (responseResult : @escaping(Root?,Error?) -> Void) {
          
          let url = URL(string: "https://s3.amazonaws.com/dev.reports.files/test.json")!
          URLSession.shared.dataTask(with: url) { data, response, error in
               let httpResponse = response as! HTTPURLResponse
              if httpResponse.statusCode == 200 {
                  if let dataSource = data{
                      let decoder = JSONDecoder()
                      let result =  try!
                      decoder.decode(Root.self, from: dataSource)
                      responseResult(result,nil)
                  }
                  if let errorSource = error{
                      responseResult(nil,errorSource)
                  }
                  
              }else{
                  print("Error en la peticion get")
                  responseResult(nil,error)
              }
              
           
              
          }.resume()
          
          //  return result
      }
    
    

}
