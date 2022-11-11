//
//  EpisodeCell.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 02.11.2022.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    static func loadFromNib() -> EpisodeCell {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        return nib.instantiate(withOwner: self).first as! EpisodeCell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
