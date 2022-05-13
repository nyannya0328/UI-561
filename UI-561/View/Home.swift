//
//  Home.swift
//  UI-561
//
//  Created by nyannyan0328 on 2022/05/13.
//

import SwiftUI

struct Home: View {
    @StateObject var model : CanVasViewModel = .init()
    var body: some View {
        ZStack{
            
            Color.black
                .ignoresSafeArea()
            
            Canvas()
                .environmentObject(model)
            
            HStack{
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "xmark")
                        .font(.title3)
                }
                
                Spacer()
                
                
                Button {
                    model.showPicker.toggle()
                } label: {
                    
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .font(.title3)
                }
                

            }
            .foregroundColor(.white)
            .maxTop()
            
            
            Button {
                
                model.saveCanvasImage(height: 250) {
                    Canvas()
                        .environmentObject(model)
                    
                    
                }
               
                
            } label: {
                
                Image(systemName: "arrow.right.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            

            
            
        }
        .preferredColorScheme(.dark)
        .alert(model.errorMSG, isPresented: $model.showError){}
        .sheet(isPresented: $model.showPicker) {
            
            if let image = UIImage(data: model.imageData){
                
                model.AddedImage(image: image)
                
            }
            
        } content: {
            
            ImagePicker(showPicker: $model.showPicker, imageData: $model.imageData)
        }

        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{

    func getRect()->CGRect{


        return UIScreen.main.bounds
    }

    func lLeading()->some View{

        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    func lTreading()->some View{

        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    func lCenter()->some View{

        self
            .frame(maxWidth:.infinity,alignment: .center)
    }

    func maxHW()->some View{

        self
            .frame(maxWidth:.infinity,maxHeight: .infinity)


    }

 func maxTop() -> some View{


        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)

    }

 func maxBottom()-> some View{

        self
            .frame(maxHeight:.infinity,alignment: .bottom)
    }

  func maxTopLeading()->some View{

        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)

    }
}
