//
//  GraficaController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 17/07/23.
//

import UIKit
import Charts

class GraficaController: UIViewController {
    var lista : [Data] = []
    
    
    
    @IBOutlet weak var pieChartView: UIView!
    
    
    @IBOutlet weak var pageControl: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        

    }
    
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        
    }
    
    func get(){
        GetViewModel.Get { response, error in
            if response?.data != nil {
                for obj in response!.data{
                    self.lista.append(obj)
                }
                //print(self.lista)
                
            }
        }
    }

  

}
