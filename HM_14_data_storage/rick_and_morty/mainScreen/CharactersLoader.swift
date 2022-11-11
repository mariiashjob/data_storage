//
//  CharactersLoader.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 01.11.2022.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class CharactersLoader {
    
    func loadAllCharacters(completion: @escaping ([Character]) -> Void) {
        AF.request("https://rickandmortyapi.com/api/character").responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                DispatchQueue.main.async {
                    if let response = Response(data: jsonDict), let characters = response.results as? [Character] {
                        completion(characters)
                    } else {
                        fatalError("The Rick and Morty API does not response data with results. \n Actual response: \n \(response)")
                    }
                }
            }
        }
    }
    
    func loadCharacterImage(url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                completion(image)
            }
        }
    }
    
    func loadCharacterEpisode(url: String, completion: @escaping (Episode) -> Void) {
        DispatchQueue.main.async {
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                    .responseJSON(completionHandler: { response in
                        switch response.result {
                        case .success:
                            if let value = response.value {
                                let json = JSON(value)
                                print("RESPONSE: \(json)")
                                let episode = Episode(name: json["name"].stringValue, episode: json["episode"].stringValue)
                                completion(episode)
                            }
                        case .failure(let error):
                            print(error)
                        }
                        
                    })
        }
    }
}
