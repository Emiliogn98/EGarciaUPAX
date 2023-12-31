//
//  TomarFotoController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 14/07/23.
//

import UIKit
import Foundation

class TomarFotoController: UIViewController {
    var base64 :  String = ""
    var imagePickerController = UIImagePickerController()
    var photoPickerController = UIImagePickerController()
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var btnGaleriaOutlet: UIButton!
    
    
    
    @IBOutlet weak var btnCamaraOutlet: UIButton!
    
    
    @IBOutlet weak var btnOcultarOutlet: UIButton!
    
    let userDefault = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foto = userDefault.string(forKey: "foto")
        if foto == "" || foto == nil {
            imageView.image = UIImage(systemName: "photo")
        }else{
            let dataDecoded : Data = Data(base64Encoded: foto!)!//Proceso inverso de base64 a Data
            imageView.image = UIImage(data: dataDecoded)
            
        }
        
       
        
        viewWillLayoutSubviews()
        
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        preferredContentSize = CGSize(width: 200, height: 200)
        
    }
    
    @IBAction func btnOcultar(_ sender: UIButton) {
        
    }
    
    
    
    
    @IBAction func btnCamara(_ sender: UIButton) {
        
        self.photoPickerController =  UIImagePickerController()
        
        self.photoPickerController.delegate = self
        
        self.photoPickerController.sourceType = .camera
        
        self.present(self.photoPickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnGaleria(_ sender: UIButton) {
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary
        self.imagePickerController.isEditing = false
        
        self.present(self.imagePickerController, animated: true)
    }
    
    
    
    
}


// MARK: UIImagePickerControllerDelegate
extension TomarFotoController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        let image = info[.originalImage]
        self.imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
        convertBase64(imagen: image as! UIImage)
    }
    
    func convertBase64(imagen: UIImage){
        let imageData = imagen.jpegData(compressionQuality: 0.0)
        
        
        self.base64 = imageData!.base64EncodedString()
      //  self.userDefault.removeObject(forKey: "foto")
        self.userDefault.set(self.base64, forKey: "foto")
        
        
        
    }
    func photoPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        var guardaImagen: UIImage?
        
        photoPickerController.dismiss(animated: true, completion: nil)
        
        self.imageView.image = info[.originalImage] as? UIImage
        
        guardaImagen = info[.originalImage] as? UIImage
        
        UIImageWriteToSavedPhotosAlbum(guardaImagen!, nil, nil, nil);
        self.userDefault.removeObject(forKey: "foto")
        self.userDefault.set(guardaImagen, forKey: "foto")
        
    }
    
    
    
}
