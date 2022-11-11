//
//  Response.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 01.11.2022.
//

import Foundation
import Alamofire
import RealmSwift

class Response {
    var info: Info?
    var results: [Character]
    
    init?(data: NSDictionary) {
        guard let infoData = data["info"] as? NSDictionary,
            let resultsData = data["results"] as? [NSDictionary]
             else { return nil }
        var results: [Character] = []
        for data in resultsData {
            if let character = Character(data: data as! NSDictionary) {
                results.append(character)
            }
        }
        self.info = Info(data: infoData as! NSDictionary)
        self.results = results
    }
}

class Info {
    var pages: Int
    var count: Int
    var prev: String?
    var next: String?
    
    init?(data: NSDictionary) {
        guard let count = data["count"] as? Int,
              let pages = data["pages"] as? Int
             else { return nil }
        
        self.pages = Int(pages)
        self.count = Int(count)
        self.prev = data["prev"] as? String
        self.next = data["next"] as? String
        
    }
}

class Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return true
    }
    
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: Episode?
    var location: Episode?
    var image: String
    var episode: [String]
    
    init?(data: NSDictionary) {
        guard let id = data["id"] as? Int,
            let name = data["name"] as? String,
            let status = data["status"] as? String,
            let species = data["species"] as? String,
            let gender = data["gender"] as? String,
            let origin = data["origin"] as? NSDictionary,
            let location = data["location"] as? NSDictionary,
            let image = data["image"] as? String
        else { return nil }
        
        self.id = Int(id)
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.origin = Episode(data: origin)
        self.location = Episode(data: location)
        self.image = image
        self.episode = data["episode"] as? [String] ?? []
    }
    
    init(id: Int,
         name: String,
         status: String,
         species: String,
         gender: String,
         origin: Episode?,
         location: Episode?,
         image: String,
         episode: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
    }
}

class Episode {
    var name: String?
    var url: String?
    var episode: String?
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
              let url = data["url"] as? String
        else { return nil }
        
        self.name = name
        self.url = url
        self.episode = data["episode"] as? String
    }
    
    init(name: String?, episode: String?, url: String? = nil) {
        self.name = name
        self.url = url
        self.episode = episode
    }
}
