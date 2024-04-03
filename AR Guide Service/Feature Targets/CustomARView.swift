//
//  CustomARView.swift
//  AR Guide Service
//
//  Created by Suyeon Cho on 01/04/24.
//

import ARKit
import Combine
import RealityKit
import SwiftUI

class CustomARView: ARView{
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    dynamic required init?(coder decoder: NSCoder){
        fatalError("init(code:) has not ceen implemented")
    }
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream(){
        ARManager.shared
            .actionStream
            .sink{ [weak self] action in
                switch action{
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                
            }
        }
            .store(in: &cancellables)
    }
    
    func configurationExample(){
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        let _ = ARGeoTrackingConfiguration()
        let _ = ARFaceTrackingConfiguration()
        let _ = ARBodyTrackingConfiguration()
    }
    
    func anchorExamples() {
        
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        let _ = AnchorEntity(plane: .horizontal)
        let _ = AnchorEntity(plane: .vertical)
        
        let _ = AnchorEntity(.face)
        
        let _ = AnchorEntity(.image(group: "group", name: "name"))
        
        scene.addAnchor(coordinateAnchor)
    }
    
    func entityExamples() {
        let _ = try? Entity.load(named:"usdzFileName")
        let _ = try? Entity.load(named:"realityFileName")
        
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh:box)
        
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    func placeBlock(ofColor color:Color) {
        let block = MeshResource.generateBox(size:1)
        let material = SimpleMaterial(color: UIColor(color), isMetallic:  false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
}

