//
//  Item.swift
//  survive-this
//
//  Created by Kelly Sun on 11/3/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    
    init(timestamp: Date) {
        self.timestamp = Date()
    }
}



//final class Photo {
//    var label: String
//    var photoPath: String
//    
//    
//    init(label: String) {
//        self.label = label
//        self.photoPath = "photo path"
//    }
//}


//struct PhotoSet: Codable{
//    var status: String
//    var photosPath: String
//    var photos: [PhotoItem]
//    
//    enum CodingKeys: String, CodingKey {
//        case status
//        case photosPath = "photos_path"
//        case photos
//    }
//}
//
//struct PhotoItem: Codable, Identifiable {
//    var id = UUID()
//    var imageName: String
//    var title: String
//    var description: String
//    var latitude: Double
//    var longitude: Double
//    var date: Date
//    
//    enum CodingKeys: String, CodingKey {
//        case imageName = "image"
//        case title
//        case description
//        case latitude
//        case longitude
//        case date
//    }
//}
