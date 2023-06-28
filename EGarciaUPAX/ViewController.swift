//
//  ViewController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 28/06/23.
//

import UIKit
import FirebaseCore
//import FirebaseFirestore
import FirebaseDatabase
import Hex



class ViewController: UIViewController {
    var ref: DatabaseReference!
    var BackgroundColor : [String] = []
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        ref = Database.database().reference()
      
        GetAll()
       // let randomColor = RandomColor()
        //view.backgroundColor = randomColor
        
        
    }
    
    @IBAction func btnAddColor(_ sender: UIButton) {

        let randomcolor = RandomColor()
      //  var color = randomcolor.description
        
        Add(color: randomcolor)
        
    }
    func Add(color : String){
        self.ref.child("Color").childByAutoId().setValue(color)
        
    }
    
    func GetAll() {
        self.ref.child( "Color") .observe (.value) { snapshot in
            if let valores = snapshot.children.allObjects as?
                [DataSnapshot]{
                for valor in valores{
                    let color = valor.value as! String
                    self.BackgroundColor.append (color)
                    DispatchQueue.main.async {
                        self.view.backgroundColor = UIColor (hex:self.BackgroundColor.last!)
                       
                      //  print(self.BackgroundColor)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
//    func RandomColor() -> String {
//

//        var red = Int.random(in: 10..<256)
//        var green = Int.random(in: 5..<256)
//        var blue = Int.random(in: 50..<256)
//        var randomColor = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
//        self.colorHex = randomColor.description
//
//        return colorHex
//    }
    func RandomColor() -> String {
        let randomHex = String(format: "#%06X", arc4random_uniform(0xFFFFFF))
        return randomHex
    }


}

