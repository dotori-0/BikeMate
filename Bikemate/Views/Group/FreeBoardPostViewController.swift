//
//  FreeBoardPostViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/20.
//

import UIKit

class FreeBoardPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var board: BoardModel!
    var board2: BoardModel!
    var board3: BoardModel!
    var boardArray: [BoardModel] = []
    var replyArray: [ReplyModel] = []
    var boardStatus: Int = 0
    
    let formatter = DateFormatter()
    var current_date_string = ""
    
    // 포스트 정보: boardModel
    @IBOutlet weak var postTitle: UILabel!
    // @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postCreatedAt: UILabel!
    
    @IBOutlet weak var postAuthor: UIButton!
    
    @IBOutlet weak var postModifyButton: UIButton!
    
    @IBOutlet weak var postDeleteButton: UIButton!
    
    // 댓글
    @IBOutlet weak var replyWriteField: UITextField!
    @IBOutlet weak var replyTableView: UITableView!
    
    @IBOutlet weak var textView: UITextView!
    
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = freeBoardTableView.dequeueReusableCell(withIdentifier: "groupcommunitymainfreeboardtableviewCell", for: indexPath) as! CommunityMainFreeBoardTableViewCell
//        cell.postTitleLabel.text = boardArray[indexPath.row].title
//        cell.clickedAction = {
//            // 클릭하면 해당하는 글의 Free Board Post View Controller로 이동
//
//        }
//
//        return cell
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        replyTableView.reloadData()
        textView.reloadInputViews()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardArray = BoardManager.shared.boardArray
        
        if boardStatus == 0 {
            // main에서 글 불러오기
            board = board2
            
        } else if boardStatus == 1 {
            // 글 쓰고 바로 글 불러오기
            board = boardArray.last
           
        } else if boardStatus == 2 {
            // 글 수정하고 수정한 글 불러오기
            board = board3
        }

        // board = boardArray.last
        replyArray = BoardManager.shared.getReplyModelFromBoard(boardId: board.uid)
        
        replyArray = replyArray.reversed()
        // Do any additional setup after loading the view.
        // boardModel = BoardManager.shared.getBoardWithUid(uid: <#T##String#>)
        
        // replyArray = BoardManager.shared.getReplys(completion: <#T##(Array<ReplyModel>) -> ()#>)
//        var board: BoardModel =  BoardManager.shared.getBoardWithUid(uid: self.boardUid)
        
        postTitle.text = board.title
        postModifyButton.isHidden = true
        postDeleteButton.isHidden = true
        textView.isEditable = false
        
        let otherUserModel = UserDatabaseManager.shared.getUserByUid(uid: board.userId)
        // postAuthor.titleLabel?.text = otherUserModel.name
        postAuthor.setTitle(otherUserModel.name, for: .normal)
        postAuthor.titleLabel?.textAlignment = NSTextAlignment.left
        
        
        postCreatedAt.text = board.createdAt
        
        textView.text = board.content
        
        replyTableView.delegate = self
        replyTableView.dataSource = self
        
        if board.userId == UserModel.shared.uid {
            postModifyButton.isHidden = false
            postDeleteButton.isHidden = false
        } else {
            postModifyButton.isHidden = true
            postDeleteButton.isHidden = true
        }
        
        
//        boardArray = BoardManager.shared.getBoardWithGroupId(groupId: UserModel.shared.groupid!).sorted { $0.modifiedAt > $1.modifiedAt}
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        replyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = replyTableView.dequeueReusableCell(withIdentifier: "freeboardpostreplytableviewCell", for: indexPath) as! FreeBoardPostReplyTableViewCell
        // cell.replyModel.uid = replyArray[indexPath.row].uid
        
        let replyModel = replyArray[indexPath.row]
        
        let otherUserModel = UserDatabaseManager.shared.getUserByUid(uid: replyArray[indexPath.row].userId)
        
        if replyModel.userId == UserModel.shared.uid {
            cell.replyDeleteButton.isHidden = false
        } else {
            cell.replyDeleteButton.isHidden = true
        }
        
        cell.replyName.text = otherUserModel.name
        cell.replayDate.text = replyModel.createdAt
        cell.replyContent.text = replyModel.content
        cell.deleteAction = {
            BoardManager.shared.removeReply(uid: self.replyArray[indexPath.row].uid)
            let idx = self.replyArray.firstIndex(where: {$0.uid == replyModel.uid})!
            self.replyArray.remove(at: idx)
            self.replyTableView.reloadData()
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func writeButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardwriteVC") as? FreeBoardWriteViewController else { fatalError() }
        viewController.board = nil
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func postModifyButton(_ sender: Any) {
//        BoardManager.updateBoard(board)
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardwriteVC") as? FreeBoardWriteViewController else { fatalError() }
        viewController.board = self.board
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func postDeleteButton(_ sender: Any) {
        BoardManager.shared.removeBoard(uid: board.uid)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func replyWriteButton(_ sender: Any) {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        current_date_string = formatter.string(from: Date())
        
        let replyModel = BoardManager.shared.postNewReplyReturnModel(boardId: board.uid, content: replyWriteField.text!, current: current_date_string)
        self.replyArray.insert(replyModel, at: 0)
        self.replyTableView.reloadData()
        
        replyWriteField.text = ""
        replyWriteField.resignFirstResponder()
        
        
        
    }
    
    
    @IBAction func boardMainButton(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func otherUserProfileButton(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "grouppersonprofileVC") as? GroupPersonProfileViewController else { fatalError() }
    
        
        let otherUserModel = UserDatabaseManager.shared.getUserByUid(uid: board.userId)

        viewController.otherUserModel = otherUserModel
        // viewController.userId = board.userId
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


class FreeBoardPostReplyTableViewCell: UITableViewCell {
    var modifyAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    var replyModel: ReplyModel!
    
    @IBOutlet weak var replyName: UILabel!
    @IBOutlet weak var replayDate: UILabel!
    @IBOutlet weak var replyModifyButton: UIButton!
    @IBOutlet weak var replyDeleteButton: UIButton!
    @IBOutlet weak var replyContent: UILabel!
    

    @IBAction func modified(_ sender: Any) {
        modifyAction!()
    }
    
    @IBAction func deleted(_ sender: Any) {
        deleteAction!()
    }
    
}
