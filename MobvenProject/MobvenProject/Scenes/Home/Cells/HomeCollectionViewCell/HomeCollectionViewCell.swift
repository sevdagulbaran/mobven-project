//
//  HomeCollectionViewCell.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var firstImage: UIImageView!
    @IBOutlet private weak var secondImage: UIImageView!
    @IBOutlet private weak var thirdImage: UIImageView!
    @IBOutlet private weak var usersCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15.0
    }
    
    private func usernameAndMessageAttributedText(for message: Groups.Fetch.ViewModel.LastMessage) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 10),
            .foregroundColor: UIColor.blueDark ?? .lightGray
        ]
        let boldText = NSAttributedString(string: message.fromUsername , attributes: boldAttributes)
        attributedText.append(boldText)
        attributedText.append(NSAttributedString(string: " "))
        attributedText.append(NSAttributedString(string: message.message ))
        return attributedText
    }
    
    func setCell(group: Groups.Fetch.ViewModel.Group) {
        groupNameLabel.text = group.name
        guard let message = group.lastMessage else { return }
        messageLabel.attributedText = usernameAndMessageAttributedText(for: message)
    }
}
