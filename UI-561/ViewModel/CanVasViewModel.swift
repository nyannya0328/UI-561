//
//  CanVasViewModel.swift
//  UI-561
//
//  Created by nyannyan0328 on 2022/05/13.
//

import SwiftUI

class CanVasViewModel:NSObject, ObservableObject {
    @Published var stackItem : [StackItem] = []
    
    @Published var showPicker : Bool = false
    @Published var imageData : Data = .init(count: 0)
    
    @Published var errorMSG : String = ""
    @Published var showError : Bool = false
    
    @Published var showDeleteAlert : Bool = false
    @Published var cirremtlyTappedItem : StackItem?
    
    
    
    func AddedImage(image : UIImage){
        
      let imageView = Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 180)
        
        
        stackItem.append(StackItem(view: AnyView(imageView)))
            
        
            
        
    }
    
    func saveCanvasImage<Content : View>(height : CGFloat,@ViewBuilder content : @escaping()->Content){
        
        
        let uiView = UIHostingController(rootView: content().padding(.top,getSafeArea().top))
        
        let frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: height))
        
        uiView.view.frame = frame
        
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        uiView.view.drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let newImage = newImage {
            
            writImage(image: newImage)
            
        }
        
        
    }
    
    func writImage(image : UIImage){
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompetition(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func saveCompetition(_ image : UIImage,didFinishSavingWithError error : Error?,contextInfo : UnsafeRawPointer){
        
        
        
        if let error = error {
        
            self.errorMSG = error.localizedDescription
            self.showError.toggle()
        }
        else{
            
            
            self.errorMSG = "Saved SCucceful"
            self.showError.toggle()
        }
        
        
    }
    
    
    
}


func getSafeArea()->UIEdgeInsets{
    
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
        
        return .zero
    }
    guard let safeArea = screen.windows.first?.safeAreaInsets else{
        
        return .zero
    }
    
    return safeArea
}



