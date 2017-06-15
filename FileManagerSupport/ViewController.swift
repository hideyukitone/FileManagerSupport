//
//  ViewController.swift
//  FileManagerSupport
//
//  Created by 大國嗣元 on 2017/06/15.
//  Copyright © 2017年 hideyuki okuni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressSelect(_ sender: Any) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func pressDelete(_ sender: Any) {
        if FileManagerSupport.delete(folderNameInDocumentDirectory: "photo", fileName: "test") {
            imageView.image = nil
        }
    }
    
    fileprivate func setImage() {
        imageView.image = FileManagerSupport.image(folderNameInDocumentDirectory: "photo", fileName: "test")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if FileManagerSupport.save(image: image, folderNameInDocumentDirectory: "photo", fileName: "test") {
                setImage()
            }else {
                imageView.image = nil
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
