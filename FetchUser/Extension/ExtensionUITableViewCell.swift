//
//  ExtensionUITableViewCell.swift
//  ChatLike
//
//  Created by Akif Demirezen on 21.01.2020.
//  Copyright © 2020 Demirezen. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)   }
}
