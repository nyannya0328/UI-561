//
//  StackItem.swift
//  UI-561
//
//  Created by nyannyan0328 on 2022/05/13.
//

import SwiftUI

struct StackItem: Identifiable {
    var id = UUID().uuidString
    
    var view : AnyView
    
    var offset : CGSize = .zero
    var lastOffset : CGSize = .zero
    
    var scale : CGFloat = 2
    var lastScale : CGFloat = 1
    
    var rotation : Angle = .zero
    var lastRotation : Angle = .zero
}

