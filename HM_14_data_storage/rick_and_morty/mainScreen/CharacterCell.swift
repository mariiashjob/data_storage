//
//  CategoryCell.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 01.11.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var userPicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusIconLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var contentCell: UIView!
    
    private let offset: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset))
        contentView.layer.cornerRadius = offset
    }
}
