//
//  ImageGalleryVC.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit

class ImageGalleryVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showCameraGalleryAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Capture photo from Camera",
                                                style: .default,
                                                handler: { action in
            alertController.dismiss(animated: true)
            self.showCameraGalleryScreen(isShowCamera: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Select photo from Gallery",
                                                style: .default,
                                                handler: { action in
            alertController.dismiss(animated: true)
            self.showCameraGalleryScreen(isShowCamera: false)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: { action in
            alertController.dismiss(animated: true)
        }))
        
        navigationController?.present(alertController, animated: true)
    }
    
    func showCameraGalleryScreen(isShowCamera: Bool) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = isShowCamera ? .camera : .photoLibrary
        self.present(pickerController, animated: true)
    }
}

extension ImageGalleryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        picker.dismiss(animated: true)
    }
}
