//
//  jsonLoader.swift
//  survive-this
//
//  Created by Kelly Sun on 11/4/23.
//

import SwiftUI

class jsonLoader {
    
    class func load(jsonFileName: String) -> AnimalList? {
        var animalList: AnimalList?
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        if let jsonFileUrl = Bundle.main.url(forResource: jsonFileName, withExtension: ".json"),
            let jsonData = try? Data(contentsOf: jsonFileUrl) {
            animalList = try? jsonDecoder.decode(AnimalList.self, from: jsonData)
        }
        
        return animalList    }
}
