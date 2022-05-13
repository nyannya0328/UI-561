//
//  Canvas.swift
//  UI-561
//
//  Created by nyannyan0328 on 2022/05/13.
//

import SwiftUI

struct Canvas: View {
    @EnvironmentObject var model : CanVasViewModel
    var height : CGFloat = 250
    var body: some View {
        GeometryReader{proxy in
            
            let size = proxy.size
            
            ZStack{
                Color.white
                
                
                ForEach($model.stackItem){$stackItem in
                    
                    CanvasSubView(stackItem: $stackItem) {
                        
                        stackItem.view
                        
                    } onMoved: {
                        
                 //   moveFrontView(stackItem: stackItem)
                        
                    } onDelete: {
                        
                        model.cirremtlyTappedItem = stackItem
                        model.showDeleteAlert.toggle()
                        
                    }
                    
                    
                    
                }
                
            }
            .frame(width: size.width, height: size.height)
            
        }
        .frame(height: height)
        .clipped()
        .alert("Are You Sure Delete View?", isPresented: $model.showDeleteAlert) {
            
            Button(role: .destructive) {
                
                if let item = model.cirremtlyTappedItem{
                    
                    let index = getIndex(stackItem: item)
                    model.stackItem.remove(at: index)
                }
                
                
            } label: {
                
                Text("Yes")
                
            }

            
            
        }
    }
    
    func moveFrontView(stackItem : StackItem){
        
        let currentIndex = getIndex(stackItem: stackItem)
        
        let lastInddex = model.stackItem.count - 1
        
        model.stackItem
            .insert(model.stackItem.remove(at: currentIndex), at: lastInddex)
        
    }
    func getIndex(stackItem : StackItem) -> Int{
        
        return model.stackItem.firstIndex { item in
            
            return item.id == stackItem.id
        } ?? 0
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CanvasSubView<Content : View> : View{
    
    var content :  Content
    @Binding var stackItem : StackItem
    
    var onMoved : ()->()
    var onDelete : ()->()
    
    init(stackItem : Binding<StackItem>,@ViewBuilder content : @escaping()->Content,onMoved : @escaping()->(),onDelete : @escaping()->()) {
        
        self.content = content()
        self._stackItem = stackItem
        self.onMoved = onMoved
        self.onDelete = onDelete
        
        
    }
    @State var happitScale : CGFloat = 1
    var body: some View{
        
        content
            .scaleEffect(stackItem.scale < 0.4 ? 0.4 : stackItem.scale)
            .offset(stackItem.offset)
            .rotationEffect(stackItem.rotation)
            .gesture(
            
            TapGesture(count: 2)
                .onEnded({ _ in
                    
                    onDelete()
                })
                .simultaneously(with: LongPressGesture(minimumDuration: 0.3)
                               
                    .onEnded({ value in
                        
                        UIImpactFeedbackGenerator(style:.medium).impactOccurred()
                        withAnimation{
                            
                            happitScale = 1.6
                        }
                        withAnimation(.easeOut(duration: 0.3).delay(0.3)){
                            
                            happitScale = 1
                        }
                        
                        onMoved()
                    })
                               
                               )
            )
            .gesture(
            
            
                DragGesture()
                    .onChanged({ value in
                        stackItem.offset = CGSize(width: stackItem.lastOffset.width + value.translation.width, height: stackItem.lastOffset.height + value.translation.height)
                        
                        
                        
                    })
                    .onEnded({ value in
                        
                        stackItem.lastOffset = stackItem.offset
                    })
            )
            .gesture(
            
            MagnificationGesture()
                .onChanged({ value in
                    
                    stackItem.scale = stackItem.lastScale + (value - 1)
                    
                    
                })
                .onEnded({ value in
                    
                    stackItem.lastScale = stackItem.scale
                })
            
                .simultaneously(with: RotationGesture()
                .onChanged({ value in
                    
                    stackItem.rotation = stackItem.lastRotation + value
                    
                })
                .onEnded({ value in
                    
                    stackItem.lastRotation = stackItem.rotation
                    
                })
                                )
            
            
            )
        
    }
    
    
}
