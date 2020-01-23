//
//  CommentsViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class PostsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldPicker: UITextField!
    
    var pickerView : UIPickerView?
    var userList : [UserModel] = []
    var postList : [PostModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    var selectedUserIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView = UIPickerView.init()
        self.pickerView!.delegate = self
        self.pickerView!.dataSource = self
        self.textFieldPicker.inputView = self.pickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTpDoneBtn))
        toolBar.setItems([flexSpace,doneButton], animated: false)
        self.textFieldPicker.inputAccessoryView = toolBar
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.getUserInfo()
    }
    
    func getUserInfo(){
           
           NetworkClient.performRequest([UserModel].self, router: APIRouter.getUser, success: { [weak self] (models) in
            self?.userList = models
            if (self?.userList.count)! > 0 {
                self?.textFieldPicker.text = self?.userList[self!.selectedUserIndex].name
                self?.getPostsOfUser(userId: (self?.userList[self!.selectedUserIndex].id)!)
            }
           }) { [weak self] (error) in
            self?.showAlertMsg(msg: error.localizedDescription, finished: {
                
            })
        }
    }
    
    func getPostsOfUser(userId : Int){
           
           NetworkClient.performRequest([PostModel].self, router: APIRouter.posts, success: { [weak self] (models) in
            if models.count > 0{
                for post in models{
                    if post.userID == userId {
                        self?.postList.append(post)
                    }
                }
            }
           }) { [weak self] (error) in
            self?.showAlertMsg(msg: error.localizedDescription, finished: {
                
            })
        }
    }
    
    @objc func didTpDoneBtn() {
        self.view.endEditing(true)
    }
}
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setInfo(post: self.postList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.willPushVC(type: .CommentsViewController) as! CommentsViewController
        vc.postId = self.postList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }
    
}
extension PostsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.userList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textFieldPicker.text = self.userList[row].name
        self.selectedUserIndex = row
        self.getPostsOfUser(userId: self.userList[self.selectedUserIndex].id)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.userList[row].name
    }
}
