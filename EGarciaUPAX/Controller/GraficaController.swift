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
    
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        data()
        

    }
    
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        
    }
    func data(){
        //  var dataEntries : [Values] = self.lista[0].values!
        var dataEntries : [Double] = [30.0,20.0,10.0]
     var dataEntriesArray : [PieChartDataEntry] = []
    
//        for obj in dataEntries {
//            let entry = PieChartDataEntry(value: dataEntries[obj], label: "Datos: ")
//            dataEntriesArray.append(entry)
//        }
        for obj in 0..<dataEntries.count {
                    let entry = PieChartDataEntry(value: dataEntries[Int(obj)], label: "Datos: ")
                    dataEntriesArray.append(entry)
                }
        let dataSet = PieChartDataSet(entries: dataEntriesArray, label: "Datos")
        let data = PieChartData(dataSet: dataSet)
        
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueTextColor = .black
        dataSet.valueFont = UIFont.systemFont(ofSize: 15)
        pieChartView.legend.enabled = true
        pieChartView.chartDescription.enabled = false
        
        pieChartView.data = data
        
        pieChartView.notifyDataSetChanged()
        
        
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
