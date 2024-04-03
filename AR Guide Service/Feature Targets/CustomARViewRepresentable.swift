//
//  CustomARViewRepresentable.swift
//  AR Guide Service
//
//  Created by Suyeon Cho on 01/04/24.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> CustomARView{
        return CustomARView()
    }
    func updateUIView(_ uiView: CustomARView, context: Context) {
    }
}
