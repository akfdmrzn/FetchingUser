//
//  PostTableViewCell.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setInfo(post : PostModel){
        self.labelTitle.text = post.title
        self.labelBody.text = post.body
    }
}
