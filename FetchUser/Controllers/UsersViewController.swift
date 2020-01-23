//
//  ViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class UsersViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var userList : [UserModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getUserInfo()
        tableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func getUserInfo(){
           
           NetworkClient.performRequest([UserModel].self, router: APIRouter.getUser, success: { [weak self] (models) in
            self?.userList = models
           }) { [weak self] (error) in
            self?.showAlertMsg(msg: error.localizedDescription, finished: {
                
            })
        }
    }
}
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.setInfo(user: self.userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.willPushVC(type: .UserDetailViewController) as! UserDetailViewController
        vc.user = self.userList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
}
