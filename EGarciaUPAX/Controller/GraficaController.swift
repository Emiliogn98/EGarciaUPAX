//
//  GraficaController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 17/07/23.
//

import UIKit
import Charts

class GraficaController: UIViewController {
    var lista : [data] = []
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
       
        self.lista
        
        switch index {
        case 0:
            
            setupPieChartView(with: lista[0])
            pieChartView.isHidden = false
          
            
            break
        case 1:
            
            
            setupPieChartView(with: lista[1])
            pieChartView.isHidden = false
            // barChartView.isHidden = false
            break
        case 2:
            
            setupPieChartView(with: lista[2])
            pieChartView.isHidden = false
            break
        case 3:
            
            setupPieChartView(with: lista[3])
            pieChartView.isHidden = false
            break
        default:
            break
        }
        
        
    }
    func setupPieChartView(with data :data){
        var dataEntries : [PieChartDataEntry] = []
        
        let title = "\(data.pregunta!)"
        let attributes : [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 23),
            .foregroundColor: UIColor.black
        ]
        let atributedTitle = NSAttributedString(string : title, attributes: attributes)
        pieChartView.centerAttributedText = atributedTitle
       pieChartView.centerTextOffset = CGPoint(x: 0, y: 0)
        
        for obj in data.values!{
            let entry = PieChartDataEntry(value: Double(obj.value!), label: "\(obj.label!) \(obj.value!)%")
            dataEntries.append(entry)
            
        }
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueTextColor = .black
        dataSet.valueFont = UIFont.systemFont(ofSize: 25)
        
        dataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: dataSet)
        // 6. Asignar el objeto PieChartData al PieChartView y actualizar la vista
        pieChartView.data = chartData
        pieChartView.notifyDataSetChanged()
        
        // 7. Otras personalizaciones adicionales que desees realizar
        let legend = pieChartView.legend
        legend.font = UIFont.boldSystemFont(ofSize: 17)
   
        legend.yEntrySpace = 30.0
        legend.xEntrySpace = 25.0
        
        pieChartView.legend.enabled = true // Mostrar leyenda
        pieChartView.chartDescription.enabled = false // Desactivar descripción de la gráfica
        
        pieChartView.holeRadiusPercent = 0.9 // Tamaño del agujero central en la gráfica de pastel
        pieChartView.rotationEnabled = true // Permite rotar la gráfica de pastel con gestos
        pieChartView.drawEntryLabelsEnabled = false
        
        
        
        
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
