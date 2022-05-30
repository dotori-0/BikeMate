//
//  GroupingResultViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/18.
//

import UIKit

class GroupingResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    var num: Int = 0
    var groupUserArray = [OtherUserModel]()
    var isRRcommend: Bool = false
    var numR: Int = 0
    var userModel: OtherUserModel!
    var recommendedGroupName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GroupManager.shared.recommendedGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupingresulttableviewCell", for: indexPath) as! GroupingResultTableViewCell
        
        let groupModel = GroupManager.shared.recommendedGroupArray[indexPath.row]
        
        cell.groupNameLabel.text = groupModel.key
        cell.groupTypeLabel.text = "\(GroupManager.shared.getGroupUserList(groupModel: groupModel).count) 명"

        cell.selectButton.layer.masksToBounds = false
        cell.selectButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.selectButton.layer.shadowOpacity = 0.28
        cell.selectButton.layer.shadowRadius = 8
        cell.selectButton.layer.cornerRadius = 15
        
        
        cell.selectAction = {
            //선택했을 때 이벤트
            cell.selectButton.backgroundColor = UIColor.lightGray
            
            UserModel.shared.groupid = groupModel.key
            self.userModel = UserDatabaseManager.shared.getUserByUid(uid: UserModel.shared.uid)
 
            GroupManager.shared.registerInGroup(groupModel: groupModel)
            GroupManager.shared.recommendedGroupArray = []
//            if self.recommendedGroupName == groupModel.key{
//                self.num = GroupManager.shared.getGroupUserList(groupModel: groupModel).count - 1
//            } else {
//                self.num = GroupManager.shared.getGroupUserList(groupModel: groupModel).count
//            }
                
            self.num = GroupManager.shared.getGroupUserList(groupModel: groupModel).count
            
            
            
            // GroupManager.shared.thisGroupUser.append(self.userModel)
//            self.num = GroupManager.shared.getGroupUserList(groupModel: groupModel).count
           // self.num = GroupManager.shared.thisGroupUser.count
            
            
            
            self.pushGroupCommunityMainVC(groupModel: groupModel)
            
                    
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    @IBAction func completeButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "priorityselectVC") as? PrioritySelectViewController else { fatalError() }
        
        GroupManager.shared.recommendedGroupArray = []
    
        // UserModel.shared.groupid = "여성강남구1시간"
        // print(UserModel.shared.groupid!)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func pushGroupCommunityMainVC(groupModel: GroupModel) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
        
        
        vc.groupModel = groupModel
        vc.boardArray = BoardManager.shared.getBoardWithGroupId(groupId: groupModel.key)
        vc.num = self.num
        
//        if (numR == num) && (isRRcommend == true) {
//            num = num - 1
//            isRRcommend = false
//        } else if (isRRcommend == true){
//
//        }
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class GroupingResultTableViewCell: UITableViewCell {
    
    var selectAction: (() -> Void)?
    
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupTypeLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selected(_ sender: Any) {
        selectAction!()
    }
    
}

