/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

struct City: Hashable, Codable, Identifiable {
    static var imagePool: [String: UIImage] = [:]
    var id: Int
    var name: String
    var country: String
    var description: String
    var imageName: String
    
    init(id: Int, name: String, country: String, description: String, imageName: String) {
        self.id = id
        self.name = name
        self.country = country
        self.description = description
        self.imageName = imageName
    }
}

extension City{
    static func toDict(city: City) -> [String: Any]{
        var dict = [String: Any]()
        
        dict["id"] = city.id
        dict["name"] = city.name
        dict["country"] = city.country
        dict["description"] = city.description
        dict["imageName"] = city.imageName

        dict["datetime"] = Date().timeIntervalSince1970
        
        return dict
    }
    
    static func fromDict(dict: [String: Any]) -> City{
        
        let id = dict["id"] as! Int
        let name = dict["name"] as! String
        let country = dict["country"] as! String
        let description = dict["description"] as! String
        let imageName = dict["imageName"] as! String

        return City(id: id, name: name, country: country, description: description, imageName: imageName)
    }
}

