//
//  GroupCommunityMainViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/18.
//

import UIKit

class GroupCommunityMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var freeBoardTableView: UITableView!
    
    // 그룹 타이틀 뷰: 그룹 속성 -> group model과 연결
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberNumber: UILabel!
   // @IBOutlet weak var groupInfo: UILabel!
    
    var groupModel: GroupModel!
    var boardArray: [BoardModel] = []
    var num: Int = 0
    var count: Int = 0
    var numR: Int = 0
    var isRRcommend: Bool = false
    // var postListArray:[BoardModel] = BoardManager.shared.getBoardsFromGroup(groupUid: <#T##String#>)
    var recommendedGroupName: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        boardArray = BoardManager.shared.getBoardWithGroupId(groupId: UserModel.shared.groupid!).sorted { $0.modifiedAt > $1.modifiedAt}
        freeBoardTableView.reloadData()
        
        // groupMemberNumber.text = "\(GroupManager.shared.getGroupUserList(groupModel: self.groupModel).count) 명"
        // GroupManager.shared.registerInGroup(groupModel: groupModel)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        freeBoardTableView.delegate = self
        freeBoardTableView.dataSource = self
     
        groupName.text = UserModel.shared.groupid
        recommendedGroupName = UserModel.shared.groupid!
        // groupInfo.text = UserModel.shared.groupid
        
        self.groupModel = GroupManager.shared.getGroup(key: UserModel.shared.groupid!)
        
        count = GroupManager.shared.getGroupUserList(groupModel: groupModel).count
        // count = GroupManager.shared.thisGroupUser.count
        
        if (num == count){
            count = count + 1
            groupMemberNumber.text = "\(count) 명"
        } else {
            groupMemberNumber.text = "\(GroupManager.shared.getGroupUserCount(groupModel: self.groupModel)) 명"
        }
        
//        if (num == count){
//            count = GroupManager.shared.getGroupUserList(groupModel: groupModel).count + 1
//
//        } else {
//            count = GroupManager.shared.getGroupUserList(groupModel: groupModel).count
//
//        }
//        groupMemberNumber.text = "\(count) 명"
//
//        if (isRRcommend == true){
//
//            isRRcommend = false
//            groupMemberNumber.text = "\(count) 명"
//
//        } else if (isRRcommend == false){
//            groupMemberNumber.text = "\(GroupManager.shared.getGroupUserCount(groupModel: self.groupModel)) 명"
//        }
//         groupMemberNumber.text = "\(GroupManager.shared.getGroupUserCount(groupModel: self.groupModel)) 명"
        // groupMemberNumber.text = "\(num) 명"
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        boardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitymainfreeboardtableviewCell", for: indexPath) as! CommunityMainFreeBoardTableViewCell
        cell.postTitleLabel.text = boardArray[indexPath.row].title
        cell.clickedAction = {
            // 클릭하면 해당하는 글의 Free Board Post View Controller로 이동
            
            guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardpostVC") as? FreeBoardPostViewController else { fatalError() }
            
//            viewController.board = self.boardArray[indexPath.row]
            // viewController.boardArray = self.boardArray
            viewController.board2 = self.boardArray[indexPath.row]
            viewController.boardStatus = 0
            
        
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    


    
    
    @IBAction func reRecommendButtonClicked(_ sender: Any) {
        
        isRRcommend = true
        

        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "priorityselectVC") as? PrioritySelectViewController else { fatalError() }
        // UserModel.shared.groupid = nil
        viewController.isRRcommend = self.isRRcommend
        viewController.numR = self.numR
        viewController.recommendedGroupName = self.recommendedGroupName
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
//
//    @IBAction func giveFeedbackButtonClicked(_ sender: Any) {
//        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "feedbackVC") as? FeedbackViewController else { fatalError() }
//    
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
//
    
    @IBAction func writeButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardwriteVC") as? FreeBoardWriteViewController else { fatalError() }
    
        viewController.board = nil
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    

    
}

class CommunityMainFreeBoardTableViewCell: UITableViewCell {
    
    var clickedAction: (() -> Void)?
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBAction func titleClicked(_ sender: Any) {
        clickedAction!()
    }
    
}
