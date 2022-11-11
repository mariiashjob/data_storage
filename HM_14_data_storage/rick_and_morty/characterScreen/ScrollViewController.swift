//
//  ScrollViewController.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 02.11.2022.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var character: Character? = nil
    var episodes: [Episode] = []
    var scrollView = UIScrollView()
    private let scrollContentView = ScrollContentView.loadFromNib()
    private let offset: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfoView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTable()
    }
    
    private func updateInfoView() {
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.addSubview(scrollContentView)
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: scrollContentView.bounds.height)
        let frame = CGRect(
            x: offset,
            y: offset,
            width: scrollView.bounds.width - offset * 2,
            height: scrollView.bounds.height - offset * 2)
        scrollContentView.frame = frame
        scrollContentView.center = self.view.center
        self.view.addSubview(scrollView)
        scrollContentView.episodesView.layer.cornerRadius = offset
        
        if let character = character {
            CharactersLoader().loadCharacterImage(url: character.image) { image in
                self.scrollContentView.imageView.image = image
            }
            scrollContentView.nameLabel.text = character.name
            scrollContentView.statusIconLabel.text = Symbols.bullet
            scrollContentView.statusIconLabel.changeBulletColor(status: character.status)
            scrollContentView.statusTextLabel.text = character.status
            scrollContentView.speciesGenderLabel.text = "\(character.species) (\(character.gender))"
            scrollContentView.locationLabel.text = character.location?.name
            scrollContentView.originLabel.text = character.origin?.name
        } else {
            let unknown = "unknown"
            scrollContentView.nameLabel.text = "The character is unknown"
            scrollContentView.statusIconLabel.text = Symbols.bullet
            scrollContentView.statusIconLabel.changeBulletColor(status: unknown)
            scrollContentView.statusTextLabel.text = unknown
            scrollContentView.speciesGenderLabel.text = unknown
            scrollContentView.locationLabel.text = unknown
            scrollContentView.originLabel.text = unknown
        }
    }
    
    private func configureTable() {
        scrollContentView.episodesTableView.delegate = self
        scrollContentView.episodesTableView.dataSource = self
        scrollContentView.episodesTableView.reloadData()
        scrollContentView.episodesTableView.layer.cornerRadius = offset
        scrollContentView.episodesTableView.reloadData()
    }
}

extension ScrollViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EpisodeCell.loadFromNib()
        cell.episodeLabel.text = episodes[indexPath.row].name
        cell.numberLabel.text = episodes[indexPath.row].episode
        return cell
    }
}
