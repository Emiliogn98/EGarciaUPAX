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



class GetController: UIViewController, UIPopoverPresentationControllerDelegate {
  
    
    
    @IBOutlet weak var btnAgregarOutlet: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var btnColor: UIButton!
    
    var ref: DatabaseReference!
    var BackgroundColor : [String] = []
    var photoPickerController = UIImagePickerController()
    var nombre : String? = nil
    var imagen : String? = nil
    var lista : [Data] = []
    let userDefault = UserDefaults.standard
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        GetAll()
        btnAgregarOutlet.isHidden = true
        configTableView()
        self.userDefault.removeObject(forKey: "foto")
        
        
//        let foto = userDefault.string(forKey: "foto")
//        imagen = foto
        
    
       
       
        
        
        
        
        
    }
    
    
    @IBAction func btnAgregar(_ sender: UIButton) {
        let foto = userDefault.string(forKey: "foto")
        imagen = foto
        var usuario = Usuario()
        usuario.Nombre = self.nombre
        usuario.Imagen = self.imagen
        
        
//        guard usuario.Nombre != nil else{
//            print("estoy aqui por que estoy vacio")
//            return
//        }
        guard usuario.Imagen != nil else{
            print("estoy aqui por que estoy vacio")
            return
        }
        
        
        GetViewModel.Add(usuario) { response, error in
            
            if response != nil {
                let alert = UIAlertController(title: "Mensaje", message: "usuario agregado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
                
            }
            else{
                print("ocurrio un error")
                let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error al agregar", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
                
                
            }
        }
    }
    
    func configTableView(){
        tableView.register(UINib(nibName: "NombreCell", bundle: nil), forCellReuseIdentifier: "NombreCell")
        tableView.register(UINib(nibName: "FotoCell", bundle: nil), forCellReuseIdentifier: "FotoCell")
        tableView.register(UINib(nibName: "DescripcionCell", bundle: nil), forCellReuseIdentifier: "DescripcionCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15
        tableView.layer.masksToBounds = true
        
    }
    @objc  func btnTomarFoto(){
        
     mostrarPopup()

    }
    
  
    @IBAction func btnAddColor(_ sender: UIButton) {
        
        let randomcolor = RandomColor()
        //  var color = randomcolor.description
        
        Add(color: randomcolor)
        
    }
    func mostrarPopup(){
        /* con storyboard, colocar identificador*/
        guard let popViewController = storyboard?.instantiateViewController(withIdentifier: "TomarFotoController") as? TomarFotoController else{
            return
        }
        popViewController.modalPresentationStyle = .popover
        popViewController.modalTransitionStyle = .crossDissolve
    
        popViewController.view.layer.cornerRadius = 15
        popViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(popViewController)
            view.addSubview(popViewController.view)
                NSLayoutConstraint.activate([
                    popViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    popViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    popViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    popViewController.view.heightAnchor.constraint(equalToConstant: 500)
                ])
        popViewController.didMove(toParent: self)
        popViewController.btnOcultarOutlet.addTarget(self, action: #selector(ocultarPopup), for: .touchUpInside)
        
       // present(popViewController, animated: true, completion: nil)
        
        /* con vista programatica*/
//        let popupViewController = TomarFotoController()
//        popupViewController.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        popupViewController.view.layer.cornerRadius = 15
//        popupViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        addChild(popupViewController)
//        view.addSubview(popupViewController.view)
//        NSLayoutConstraint.activate([
//            popupViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            popupViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            popupViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            popupViewController.view.heightAnchor.constraint(equalToConstant: 600)
//        ])
//        popupViewController.didMove(toParent: self)
        
        /*1 */
//        let popupViewController = TomarFotoController()
//        popupViewController.modalPresentationStyle = .overCurrentContext
//        popupViewController.modalTransitionStyle = .crossDissolve
//        present(popupViewController,animated: true, completion: nil)
        
        /* 2*/
//            let popViewController = TomarFotoController()
//            self.addChild(popViewController)
//            popViewController.view.frame = self.view.bounds
//            self.view.addSubview(popViewController.view)
//            popViewController.didMove(toParent: self)
        
        
        
        /*3 para ipad*/
//        let TomarFoto = TomarFotoController()
//       // let TomarFoto = TestController()
//        TomarFoto.modalPresentationStyle = .popover
//
//
//        let popoverPresentationController = TomarFoto.popoverPresentationController
//        popoverPresentationController?.permittedArrowDirections = .any
//        popoverPresentationController?.sourceView = self.view
//        popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//        popoverPresentationController?.delegate = self
//
//        present(TomarFoto, animated: true, completion: nil)
    }
    @objc func ocultarPopup(){
        guard let popupViewController = children.first as? TomarFotoController else {
            return
        }
        
        popupViewController.willMove(toParent: nil)
        popupViewController.view.removeFromSuperview()
        popupViewController.removeFromParent()
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
                       // self.tableView.backgroundColor = UIColor (hex:self.BackgroundColor.last!)
                        self.btnColor.tintColor = UIColor (hex:self.BackgroundColor.last!)
                       
                        
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

        print(textField.text)
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
           
           // self.nombre = cell.txtNombre.text!
   
            
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            
        }
        if indexPath.row == 2 {
           
            self.performSegue(withIdentifier: "GraficaSegue", sender: self)
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
        self.nombre = textField.text
        if nombre != "" {
           
            DispatchQueue.main.async {
                self.btnAgregarOutlet.isHidden = false
            }
        }else{
            DispatchQueue.main.async {
                self.btnAgregarOutlet.isHidden = true
            }
        }
        //print(self.nombre)
    }
}
