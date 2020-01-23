//
//  CommentsViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit

class CommentsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var postId : Int?
    var commentList : [CommentsModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.register(CommentsTableViewCell.nib, forCellReuseIdentifier: CommentsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.getCommentsInfo(postId: self.postId!)
    }
    
    func getCommentsInfo(postId : Int){
           
           NetworkClient.performRequest([CommentsModel].self, router: APIRouter.comments, success: { [weak self] (models) in
            if models.count > 0{
                for comment in models{
                    if comment.postID == postId {
                        self?.commentList.append(comment)
                    }
                }
            }
           }) { [weak self] (error) in
            self?.showAlertMsg(msg: error.localizedDescription, finished: {
                
            })
        }
    }
}
extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier, for: indexPath) as! CommentsTableViewCell
        cell.setInfo(comments: self.commentList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentList.count
    }
    
}

