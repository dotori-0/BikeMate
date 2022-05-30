//
//  FreeBoardWriteViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/20.
//

import UIKit

class FreeBoardWriteViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var contentTF: UITextView!
    
    @IBOutlet weak var postButton: UIButton!
    var board: BoardModel!
    
    let formatter = DateFormatter()
    var current_date_string = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if board == nil{
            placeholderSetting()
        } else {
            titleTF.text = board.title
            contentTF.text = board.content
        }
        
        
        
    }
    
    private func placeholderSetting() {
        contentTF.delegate = self
        contentTF.delegate = self // txtvReview가 유저가 선언한 outlet
        contentTF.text = "내용을 입력하세요."
        contentTF.textColor = UIColor.lightGray
        
    }
    

    @IBAction func listButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func writeButtonClicked(_ sender: Any) {
        if board == nil{
            // 새 글 작성
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            current_date_string = formatter.string(from: Date())
            
            BoardManager.shared.postNewBoardInGroupWithTime(title: titleTF.text!, content: contentTF.text!, groupId: UserModel.shared.groupid!, created: current_date_string)
            // BoardManager.shared.postNewBoardInGroup(title: titleTF.text!, content: contentTF.text!, groupId: UserModel.shared.groupid!)
            
            guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardpostVC") as? FreeBoardPostViewController else { fatalError() }
            
            viewController.boardStatus = 1
            
            
        
            // test
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            //self.navigationController?.popViewController(animated: true)
        } else {
            // 글 수정
            BoardManager.shared.updateBoard(uid: board.uid, title: titleTF.text!, content: contentTF.text!)
            
            guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "freeboardpostVC") as? FreeBoardPostViewController else { fatalError() }
            
            viewController.board3 = self.board
            viewController.boardStatus = 2
            
        
            self.navigationController?.pushViewController(viewController, animated: true)
            
            // self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func boardMainButton(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
    
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }

}





extension FreeBoardWriteViewController: UITextViewDelegate {
// TextView Place Holder
func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
        textView.text = nil
        textView.textColor = UIColor.black
    }
    
}
// TextView Place Holder
func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
        textView.text = "내용을 입력하세요."
        textView.textColor = UIColor.lightGray
    }
}
}

