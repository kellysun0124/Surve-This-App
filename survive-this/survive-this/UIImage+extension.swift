//
//  UIImage+extension.swift
//  survive-this
//
//  Created by Kelly Sun on 11/3/23.
//

//
//import Foundation
//import UIKit
//
//extension UIImage {
//    
//     //convert A image to cv Pixel Buffer with 224*224
//    func convertImage(image: UIImage) -> CVPixelBuffer? {
//
//        let newSize = CGSize(width: 224.0, height: 224.0)
//            UIGraphicsBeginImageContext(newSize)
//            image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
//
//        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
//            return nil
//        }
//
//        UIGraphicsEndImageContext()
//
//        // convert to pixel buffer
//
//        let attributes = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
//                          kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer: CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                         Int(newSize.width),
//                                         Int(newSize.height),
//                                         kCVPixelFormatType_32ARGB,
//                                         attributes,
//                                         &pixelBuffer)
//
//        guard let createdPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
//            return nil
//        }
//
//        CVPixelBufferLockBaseAddress(createdPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//        let pixelData = CVPixelBufferGetBaseAddress(createdPixelBuffer)
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        guard let context = CGContext(data: pixelData,
//                                      width: Int(newSize.width),
//                                      height: Int(newSize.height),
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: CVPixelBufferGetBytesPerRow(createdPixelBuffer),
//                                      space: colorSpace,
//                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
//                                        return nil
//        }
//
//        context.translateBy(x: 0, y: newSize.height)
//        context.scaleBy(x: 1.0, y: -1.0)
//
//        UIGraphicsPushContext(context)
//        resizedImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        UIGraphicsPopContext()
//        CVPixelBufferUnlockBaseAddress(createdPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//
//        return createdPixelBuffer
//    }

    
//    func resizeImageTo(size: CGSize) -> UIImage? {
//        
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return resizedImage
//    }
    
//    
//    
//    func convertToBuffer() -> CVPixelBuffer? {
//        
//        let attributes = [
//            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
//            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
//        ] as CFDictionary
//        
//        var pixelBuffer: CVPixelBuffer?
//        
//        let status = CVPixelBufferCreate(
//            kCFAllocatorDefault, Int(self.size.width),
//            Int(self.size.height),
//            kCVPixelFormatType_32ARGB,
//            attributes,
//            &pixelBuffer)
//        
//        guard (status == kCVReturnSuccess) else {
//            return nil
//        }
//        
//        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        
//        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        let context = CGContext(
//            data: pixelData,
//            width: Int(self.size.width),
//            height: Int(self.size.height),
//            bitsPerComponent: 8,
//            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
//            space: rgbColorSpace,
//            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//        
//        context?.translateBy(x: 0, y: self.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        
//        UIGraphicsPushContext(context!)
//        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        UIGraphicsPopContext()
//        
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        
//        return pixelBuffer
//    }
//    



