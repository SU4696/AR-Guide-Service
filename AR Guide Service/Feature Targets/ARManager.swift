//
//  ARManager.swift
//  AR Guide Service
//
//  Created by Suyeon Cho on 02/04/24.
//

import Combine

class ARManager{
     static let shared = ARManager()
    private init() {}
    
     var actionStream = PassthroughSubject<ArAction, Never>()
    
    
    
}
