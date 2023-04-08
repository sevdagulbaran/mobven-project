//
//  HomeTableViewCell.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var namaLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    func configureCell(viewModel: Groups.Fetch.ViewModel.Group) {
        
            viewModel.users?.forEach { user in
                namaLabel?.text = user.nameSurname
                messageLabel?.text = user.title
                
            }
           
            //momentumv2.mobven.com:7076/E2EE07CD-BC70-4E44-BD0C-D26448F2DF3B.jpg
            //guard let profilePhoto = viewModel.profilePhoto else { return}
            //self.profileImage.loadFrom(stringURL: profilePhoto)
           
    }
}
