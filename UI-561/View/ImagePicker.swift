//
//  ImagePicker.swift
//  UI-561
//
//  Created by nyannyan0328 on 2022/05/13.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showPicker : Bool
    @Binding var imageData : Data
    
    var quority : CGFloat = 0.5
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
        
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
        
    }
    
    class Coordinator : NSObject,PHPickerViewControllerDelegate{
     
        
        var parent : ImagePicker
        init(parent : ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if let image = results.first?.itemProvider{
                
                image.loadObject(ofClass: UIImage.self) { image, err in
                    
                    
                    if let data = (image as? UIImage)?.jpegData(compressionQuality: self.parent.quority){
                        
                        DispatchQueue.main.async {
                            self.parent.imageData = data
                            self.parent.showPicker.toggle()
                        }
                    }
                }
                
                
            }
            else{
                
                self.parent.showPicker.toggle()
            }
            
            
        }
        
        
        
    }
}


