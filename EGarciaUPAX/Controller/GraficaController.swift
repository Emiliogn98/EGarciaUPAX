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
    var valores : [Double] = []
    
    
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
       
     
        

    }
    
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        showChart(at: sender.currentPage)
        
    }
    func pageControlMethod(){
        
        pageControl.numberOfPages = lista.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
        
        showChart(at: 0)
    }
 
    func showChart(at index: Int){
        pieChartView.isHidden = true
        barChartView.isHidden = true
        self.lista
        
        switch index {
        case 0:
            let dataValues : [Data] = lista.map {$0}
            setupPieChartView(with: dataValues)
            pieChartView.isHidden = false
            
            break
        case 1:
            let dataValues : [Data] = lista.map {$0}
           
            setupPieChartView(with: dataValues)
            pieChartView.isHidden = false
           // barChartView.isHidden = false
            break
        case 2:
            let dataValues : [Data] = lista.map {$0}
            setupPieChartView(with: dataValues)
            pieChartView.isHidden = false
            break
        case 3:
            let dataValues : [Data] = lista.map {$0}
            setupPieChartView(with: dataValues)
            pieChartView.isHidden = false
            break
        default:
            break
        }
        
        
    }
    func setupPieChartView(with data :[Data]){
        var dataEntries : [PieChartDataEntry] = []
        for (index, value) in data.enumerated(){
            let entry = PieChartDataEntry(value: Double(value.values![index].value!), label: "\(value.values![index].label!) ")
            dataEntries.append(entry)
            
        }
            let dataSet = PieChartDataSet(entries: dataEntries, label: "")
            
            dataSet.colors = ChartColorTemplates.joyful()
            dataSet.valueTextColor = .black
            dataSet.valueFont = UIFont.systemFont(ofSize: 20)
        
            let chartData = PieChartData(dataSet: dataSet)

             
            let centerText = "Gráfica de Pastel"
            chartData.setDrawValues(false) // Desactiva la visualización de valores en las partes de la gráfica
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
      

            // 6. Asignar el objeto PieChartData al PieChartView y actualizar la vista
            pieChartView.data = chartData
            pieChartView.notifyDataSetChanged()

            // 7. Otras personalizaciones adicionales que desees realizar
            pieChartView.legend.enabled = true // Mostrar leyenda
            pieChartView.chartDescription.enabled = false // Desactivar descripción de la gráfica
            pieChartView.holeRadiusPercent = 0.4 // Tamaño del agujero central en la gráfica de pastel
            pieChartView.rotationEnabled = true // Permite rotar la gráfica de pastel con gestos
            
            
        
        
    }
    func data(){
        var dataEntries = self.lista
        print(self.lista)
    //    var dataEntries : [Double] = [30.0,20.0,10.0]
     var dataEntriesArray : [PieChartDataEntry] = []
    
        for data in dataEntries[0].values! {
            //self.valores = data.values! as! [Double]
            
            let entry = PieChartDataEntry(value: Double(data.value!), label: "\(data.label!)")
            dataEntriesArray.append(entry)
        }
//        for obj in 0..<dataEntries.count {
//            let entry = PieChartDataEntry(value: dataEntries[Data(from: obj as! Decoder)], label: "Datos: ")
//                    dataEntriesArray.append(entry)
//                }
        let dataSet = PieChartDataSet(entries: dataEntriesArray, label: "")
        
        let data = PieChartData(dataSet: dataSet)
        
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueTextColor = .black
        dataSet.valueFont = UIFont.systemFont(ofSize: 20)
        pieChartView.legend.enabled = true
        pieChartView.chartDescription.enabled = false
        
        pieChartView.data = data
        
        pieChartView.notifyDataSetChanged()
        
        
    }
    func get(){
        GetViewModel.Get { response, error in
            
            DispatchQueue.main.async {
                if response?.data != nil {
                    for obj in response!.data{
                        self.lista.append(obj)
                    }
                    //print(self.lista)
                   // self.data()
                    self.pageControlMethod()
                }
            }
        }
    }

  

}
