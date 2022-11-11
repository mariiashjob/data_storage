//
//  MainViewController.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 01.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var characters: [Character] = RealmShared.getAllCharacters()
    var episode: Episode? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CharactersLoader().loadAllCharacters { charactersLoaded in
            RealmShared.addAllCharacters(charactersLoaded)
            if self.characters != charactersLoaded {
                self.characters = charactersLoaded
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !characters.isEmpty {
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name
        cell.statusIconLabel.text = Symbols.bullet
        cell.statusIconLabel.changeBulletColor(status: character.status)
        cell.statusTextLabel.text = " \(character.status) - \(character.species)"
        cell.locationLabel.text = character.location?.name
        CharactersLoader().loadCharacterImage(url: character.image) { image in
            cell.userPicImageView.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(identifier: "ScrollViewController") as? ScrollViewController {
            let character = characters[indexPath.row]
            viewController.character = character
            for url in character.episode {
                CharactersLoader().loadCharacterEpisode(url: url) { episode in
                    viewController.episodes.append(episode)
                }
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
