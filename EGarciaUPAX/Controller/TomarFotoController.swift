//
//  TomarFotoController.swift
//  EGarciaUPAX
//
//  Created by MacBookMBA4 on 14/07/23.
//

import UIKit

class TomarFotoController: UIViewController {
    var base64 :  String = ""
    var imagePickerController = UIImagePickerController()
    var photoPickerController = UIImagePickerController()
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var btnGaleriaOutlet: UIButton!
    
    
    
    @IBOutlet weak var btnCamaraOutlet: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        });
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
        
        
        
    }
    func photoPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        var guardaImagen: UIImage?
        
        photoPickerController.dismiss(animated: true, completion: nil)
        
        self.imageView.image = info[.originalImage] as? UIImage
        
        guardaImagen = info[.originalImage] as? UIImage
        
        UIImageWriteToSavedPhotosAlbum(guardaImagen!, nil, nil, nil);
        
    }
    
    
    
}
