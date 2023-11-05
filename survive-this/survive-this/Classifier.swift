//
//  Classifier.swift
//  survive-this
//
//  Created by Kelly Sun on 11/4/23.
//

import CoreML
import CoreImage
import Vision

struct Classifier {
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: MobileNetV2FP16(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        
        if let firstResult = results.first {
            self.results = firstResult.identifier
        }
        
    }
    
}

//struct Classifier {
//    let model: MobileNetV2FP16 = {
//
//            do {
//
//                let config = MLModelConfiguration()
//                return try MobileNetV2FP16(configuration: config)
//
//            } catch {
//
//                print(error)
//                fatalError("Couldn't create MobileNetV2FP16")
//
//            }
//    }()
//    @State var classificationLabel: String = "this is a..."
//
//    func classifyImage(photo: UIImage){
//        //change string to uiimage
//        //let image = UIImage(named: photo)!
//        
//        if let imagebuffer = photo.convertImage(image: photo) {
//            do {
//                let prediction = try model.prediction(image: imagebuffer)
//                classificationLabel = prediction.classLabel
////                if let firstresult = classificationLabel.first {
////                    self.classificationLabel = String(firstresult)
////                }
//            } catch let error {
//                print("error: ", error)
//            }
//        }
//    }
//}
