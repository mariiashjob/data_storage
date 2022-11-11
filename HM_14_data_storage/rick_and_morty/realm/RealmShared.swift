//
//  RealmShared.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 11.11.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmCharacter: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var origin: RealmEpisode? = nil
    @objc dynamic var location: RealmEpisode? = nil
    @objc dynamic var image: String = ""
}

class RealmEpisode: Object {
    @objc dynamic var characterId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String? = nil
    @objc dynamic var episode: String? = nil
}


class RealmShared {
    
    static let shared = RealmShared()
    static let realm = try! Realm()
    
    static func addAllCharacters(_ characters: [Character]) {
        deleteAll()
        try! realm.write {
            for character in characters {
                let realmCharacter = convertCharacterToObject(character) { episodes in
                    for episode in episodes {
                        let realEpisode = convertEpisodeToObject(
                            url: episode,
                            characterId: character.id
                        )
                        realm.add(realEpisode)
                    }
                }
                realm.add(realmCharacter)
            }
        }
    }
    
    static func convertCharacterToObject(_ character: Character, completion: @escaping ([String]) -> Void) -> RealmCharacter {
        let object = RealmCharacter()
        let origin = RealmEpisode()
        origin.name = character.origin?.name ?? ""
        origin.url = character.origin?.url
        origin.episode = character.origin?.episode
        let location = RealmEpisode()
        location.name = character.location?.name ?? ""
        location.url = character.location?.url
        location.episode = character.location?.episode
        object.id = character.id
        object.name = character.name
        object.status = character.status
        object.species = character.species
        object.gender = character.gender
        object.origin = origin
        object.location = location
        object.image = character.image
        completion(character.episode)
        return object
    }
    
    static func convertEpisodeToObject(url: String, characterId: Int) -> RealmEpisode {
        let object = RealmEpisode()
        object.characterId = characterId
        object.url = url
        return object
    }
    
    static func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func getEpisodesNames(for characterId: Int) -> [String] {
        let results = realm.objects(RealmEpisode.self)
        var episodes: [String] = []
        for result in results {
            episodes.append(result.url ?? "")
        }
        return episodes
    }
    
    static func getAllCharacters() -> [Character] {
        var characters: [Character] = []
        for realmCharacter in realm.objects(RealmCharacter.self) {
            let character = Character(
                id: realmCharacter.id,
                name: realmCharacter.name,
                status: realmCharacter.status,
                species: realmCharacter.species,
                gender: realmCharacter.gender,
                origin: Episode(name: realmCharacter.origin?.name, episode: realmCharacter.origin?.episode, url: realmCharacter.origin?.url),
                location: Episode(name: realmCharacter.location?.name, episode: realmCharacter.location?.episode, url: realmCharacter.location?.url),
                image: realmCharacter.image,
                episode: getEpisodesNames(for: realmCharacter.id)
            )
            characters.append(character)
        }
        return characters
    }
}
