//
//  ImageClassifier.swift
//  survive-this
//
//  Created by Kelly Sun on 11/4/23.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        if classifier.results != nil {
            if classifier.results!.contains(", "){
                let seperated = classifier.results!.split(separator: ", ")
                let first: String = String(seperated.first!)
                return first
            } else {
                return classifier.results
            }
        } else {
            return classifier.results
        }
    }

        
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
        
}
