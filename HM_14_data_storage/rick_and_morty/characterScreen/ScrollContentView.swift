//
//  ScrollContentView.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 02.11.2022.
//

import UIKit

class ScrollContentView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusIconLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var speciesGenderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var episodesTableView: UITableView!
    
    static func loadFromNib() -> ScrollContentView {
        let nib = UINib(nibName: "ScrollContentView", bundle: nil)
        return nib.instantiate(withOwner: self).first as! ScrollContentView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
