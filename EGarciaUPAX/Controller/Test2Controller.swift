//
//  Test2Controller.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 18/07/23.
//

import UIKit
import Charts

class Test2Controller: UIViewController {
    var lista : [data] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
//    func createSlides() -> [Slide] {
//
//            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide1.imageView.image = UIImage(named: "ic_onboarding_1")
//            slide1.labelTitle.text = "A real-life bear"
//            slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//            
//            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide2.imageView.image = UIImage(named: "ic_onboarding_2")
//            slide2.labelTitle.text = "A real-life bear"
//            slide2.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//            
//            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide3.imageView.image = UIImage(named: "ic_onboarding_3")
//            slide3.labelTitle.text = "A real-life bear"
//            slide3.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//            
//            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide4.imageView.image = UIImage(named: "ic_onboarding_4")
//            slide4.labelTitle.text = "A real-life bear"
//            slide4.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//            
//            
//            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide5.imageView.image = UIImage(named: "ic_onboarding_5")
//            slide5.labelTitle.text = "A real-life bear"
//            slide5.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//            
//            return [slide1, slide2, slide3, slide4, slide5]
//        }
//    func setupSlideScrollView(slides : [Slide]) {
//        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
//        scrollView.isPagingEnabled = true
//
//        for i in 0 ..< slides.count {
//            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
//            scrollView.addSubview(slides[i])
//        }
    
    func showChart(at index: Int){
       
       
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
        var dataEntriesArray : [PieChartDataEntry] = []
        for data in dataEntries[0].values! {
          
            let entry = PieChartDataEntry(value: Double(data.value!), label: "\(data.label!)")
            dataEntriesArray.append(entry)
        }
   
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
//                    self.pageControlMethod()
                }
            }
        }
    }
    


}
