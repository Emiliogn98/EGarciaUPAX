//
//  ViewController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 28/06/23.
// https://stackoverflow.com/questions/44709096/pop-up-view-in-swift
// https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import Hex



class GetController: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var btnColor: UIButton!
    
    var ref: DatabaseReference!
    var BackgroundColor : [String] = []
    var photoPickerController = UIImagePickerController()
    var nombre : String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        GetAll()
        configTableView()
       
       
        
        
        
        
        
    }
    func configTableView(){
        tableView.register(UINib(nibName: "NombreCell", bundle: nil), forCellReuseIdentifier: "NombreCell")
        tableView.register(UINib(nibName: "FotoCell", bundle: nil), forCellReuseIdentifier: "FotoCell")
        tableView.register(UINib(nibName: "DescripcionCell", bundle: nil), forCellReuseIdentifier: "DescripcionCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @objc  func btnTomarFoto(){
    
        let vc = TomarFotoController(nibName: "TomarFotoController", bundle: nil)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext

        self.present(vc, animated: true)
        
//        let popOverVC = UIStoryboard(name: "SpinningWheel", bundle: nil).instantiateViewController(withIdentifier: "TomarFotoController") as! TomarFotoController
//        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        tabBarController!.present(popOverVC, animated: true)

        
        
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
    @objc func textChange(_ textField: UITextField) {

     //   print(textField.text)
        self.nombre = textField.text!
    }

    
    
}


//MARK: tableview Delegate, DataSource

extension GetController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let opc = indexPath.row
        
        switch opc {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "NombreCell", for: indexPath) as! NombreCell
            
            cell.txtNombre.delegate = self
      //      cell.txtNombre.addTarget(self, action: #selector(textChange), for: .editingChanged)
            
            return cell
            break
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FotoCell", for: indexPath) as! FotoCell
            cell.btnFoto.tag = indexPath.row
            cell.btnFoto.addTarget(self, action: #selector(btnTomarFoto), for: .touchUpInside)
            return cell
            break
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescripcionCell", for: indexPath) as! DescripcionCell
            cell.lblDescripcion.text = "Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, medianterecursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental)."
            return cell
            break
        default:
            return UITableViewCell()
            break
            
        }
        
    }
    
}

// MARK: UIImagePickerControllerDelegate
extension GetController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    func photoPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {

      var guardaImagen: UIImage?

        photoPickerController.dismiss(animated: true, completion: nil)

     //   self.imageView.image = info[.originalImage] as? UIImage

        guardaImagen = info[.originalImage] as? UIImage

        UIImageWriteToSavedPhotosAlbum(guardaImagen!, nil, nil, nil);

      }
    
    
    
}

//MARK: textfield delegate

extension GetController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

                   do {
                      let regex = try NSRegularExpression(pattern: ".*[^A-Za-zf/].*", options: [])
                  
                       if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                           return false
                       }
                   }
                   catch {
                       print("ERROR")
                   }
               return true
       }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
}
