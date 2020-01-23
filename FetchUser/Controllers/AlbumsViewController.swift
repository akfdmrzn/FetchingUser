//
//  AlbumsViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class AlbumsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldPicker: UITextField!
    
    var pickerView : UIPickerView?
    var userList : [UserModel] = []
    var albumsList : [AlbumModel] = []{
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
        tableView.register(AlbumTableViewCell.nib, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.getUserInfo()
    }
    
    func getUserInfo(){
           
           NetworkClient.performRequest([UserModel].self, router: APIRouter.getUser, success: { [weak self] (models) in
            self?.userList = models
            if (self?.userList.count)! > 0 {
                self?.textFieldPicker.text = self?.userList[self!.selectedUserIndex].name
                self?.getAlbumsOfUser(userId: (self?.userList[self!.selectedUserIndex].id)!)
            }
           }) { [weak self] (error) in
            self?.showAlertMsg(msg: error.localizedDescription, finished: {
                
            })
        }
    }
    
    func getAlbumsOfUser(userId : Int){
           
           NetworkClient.performRequest([AlbumModel].self, router: APIRouter.albums, success: { [weak self] (models) in
            if models.count > 0{
                for post in models{
                    if post.userID == userId {
                        self?.albumsList.append(post)
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
extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as! AlbumTableViewCell
        cell.setInfo(name: self.userList[self.selectedUserIndex].name, albumTitle: self.albumsList[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.willPushVC(type: .PhotosViewController) as! PhotosViewController
        vc.albumId = self.albumsList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsList.count
    }
    
}
extension AlbumsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.userList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textFieldPicker.text = self.userList[row].name
        self.selectedUserIndex = row
        self.getAlbumsOfUser(userId: self.userList[self.selectedUserIndex].id)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.userList[row].name
    }
}
