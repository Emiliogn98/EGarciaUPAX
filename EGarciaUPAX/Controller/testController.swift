//
//  testController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 18/07/23.
//

import UIKit
import Charts

class testController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    let scrollView = UIScrollView(frame: CGRect(x:50, y:130, width:300,height: 650))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
       var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
       var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))

 
    var lista : [data] = []
    
    private let view2 : PieChartView = {
         let view2 = PieChartView(frame: CGRect(x: 50, y: 130, width: 300, height: 650))
         // let view2 = UIView()
         view2.backgroundColor = UIColor(named: "fondodegradado")
         view2.layer.cornerRadius = 15
         view2.layer.masksToBounds = true
         return view2
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        configurePageControl()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        self.view.addSubview(scrollView)
        //self.view.addSubview(view2)
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size

            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
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
    func get(){
        GetViewModel.Get { response, error in
            
            DispatchQueue.main.async {
                if response?.data != nil {
                    for obj in response!.data{
                        self.lista.append(obj)
                    }
               
                    self.configurePageControl()
                }
            }
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
   
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl.numberOfPages = lista.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    
}




