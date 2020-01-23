//
//  CommentsTableViewCell.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imageViewUser?.layer.borderColor = UIColor.systemBlue.cgColor
        self.imageViewUser?.layer.borderWidth = 1.0
        self.imageViewUser?.layer.cornerRadius = (self.imageViewUser?.frame.size.width)! / 2.0
        self.imageViewUser?.layer.masksToBounds = true
    }
    
    func setInfo(comments : CommentsModel){ //For CommentsVC
        self.labelName.text = comments.email
        self.labelTitle.text = comments.name
        self.labelBody.text = comments.body
    }
}
