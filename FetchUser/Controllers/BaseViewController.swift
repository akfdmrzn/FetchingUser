//
//  BaseViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    public var tagHash : [String:UIView]  = [String:UIView]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle  = .light
        }
        // Do any additional setup after loading the view.
    }
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    func pushVC(type : ControllerIdentifiers){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: type.rawValue)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func presentVC(type : ControllerIdentifiers){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: type.rawValue)
        self.navigationController?.present(viewController, animated: true)
    }
    func willPushVC(type : ControllerIdentifiers) -> UIViewController{
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: type.rawValue)
    }
}
