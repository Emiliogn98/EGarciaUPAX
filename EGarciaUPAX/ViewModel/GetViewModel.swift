//
//  GetViewModel.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 14/07/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

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
    static func Add(_ usuario : Usuario, responseResult : @escaping(Result?, Error?)-> Void){
        var result = Result()
          let db = Firestore.firestore()
          var ref: DocumentReference? = nil
          
          ref = db.collection("Usuario").addDocument(data: [
            "Nombre": "\(usuario.Nombre)",
            "Imagen": "\(usuario.Imagen)",
       
          ]){ err in
              if let err = err {
                  print("Error adding document: \(err)")
                  result.Correct = false
                  
              } else {
                  print("Document added with ID: \(ref!.documentID)")
                 result.Correct = true
              }
              
              responseResult(result, nil)
          }
    
      }
    
    
    
    

}
