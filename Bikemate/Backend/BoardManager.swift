//
//  BoardManager.swift
//  Bikemate
//
//  Created by new on 2022/02/13.
//

import UIKit
import Firebase
import FirebaseDatabase

class BoardManager {
     
    private let rootRef = Database.database().reference()
    
    static let shared = BoardManager() //규칙 1
    
    let formatter = DateFormatter()
    var current_date_string = ""
    
    var boardArray: [BoardModel] = []
    var replyArray: [ReplyModel] = []
    
    private init() { //규칙 2
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        current_date_string = formatter.string(from: Date())
        
        //postNewBoard(title: "테스트", content: "good") // 게시글 등록 테스트
        
        
        self.getAllBoards { boardArray in
            self.boardArray = boardArray
            
        }
        
        self.getReplys { replyArray in
            self.replyArray = replyArray
        }
        
    }
    
    
    
    /* 새로운 게시글 등록 */
    
    func postNewBoardInGroup(title:String, content:String, groupId: String)
    {
        let key: String = rootRef.childByAutoId().key!
        let itemRef = rootRef.child("board").child(key)
        
        
        //현재 시간 받아오기
        //let date = Date.now
        let values: [String: Any] = [ "userId": UserModel.shared.uid,
                                      "title":title,
                                      "content":content,
                                      "createdAt":current_date_string,
                                      "modifiedAt":current_date_string,
                                      "uid": key,
                                      "groupId":groupId]
        
        let boardModel = BoardModel(uid: key, userId: UserModel.shared.uid, groupId: groupId, title: title, content: content, createdAt: current_date_string, modifiedAt: current_date_string)
        
        self.boardArray.append(boardModel)
        itemRef.setValue(values)
    }
    
    
    
    func postNewBoardInGroupWithTime(title:String, content:String, groupId: String, created: String)
        {
            let key: String = rootRef.childByAutoId().key!
            let itemRef = rootRef.child("board").child(key)
            
            
            //현재 시간 받아오기
            //let date = Date.now
            let values: [String: Any] = [ "userId": UserModel.shared.uid,
                                          "title":title,
                                          "content":content,
                                          "createdAt":created,
                                          "modifiedAt":created,
                                          "uid": key,
                                          "groupId":groupId]
            
            let boardModel = BoardModel(uid: key, userId: UserModel.shared.uid, groupId: groupId, title: title, content: content, createdAt: created, modifiedAt: created)
            
            self.boardArray.append(boardModel)
            itemRef.setValue(values)
        }
    
    
    
    /* 모든 게시글 가져오기 (전체 글 열람)*/
    func getAllBoards(completion: @escaping (Array<BoardModel>) -> ()){
        
        rootRef.child("board").observeSingleEvent(of: .value, with: { snapshot in
            var boards: Array<BoardModel> = Array<BoardModel>()
            for child in snapshot.children {
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                
                let uid = dataSnapshot?.key ?? ""
                let userId = item?["userId"] as? String ?? ""
                let title = item?["title"] as? String ?? ""
                let content = item?["content"] as? String ?? ""
                let createdAt = item?["createdAt"] as? String ?? ""
                let modifiedAt = item?["modifiedAt"] as? String ?? ""
                let groupId = item?["groupId"] as? String ?? ""

                
                let boardModel = BoardModel(uid: uid, userId: userId, groupId: groupId, title: title, content: content, createdAt: createdAt, modifiedAt: modifiedAt)
                boards.append(boardModel)
            }
            completion(boards)
        })
    }
    
    
    /* 하나의 게시글 가져오기 */
    func getBoardWithUid(uid: String) -> BoardModel {
        return self.boardArray.filter { $0.uid == uid }.first!
    }
    
    func getBoardWithGroupId(groupId: String) -> [BoardModel] {
        return self.boardArray.filter { $0.groupId == groupId }
    }
    
    
    //속도
    
    // BoardModel 리턴
    // var boardModel: BoardModel? = nil
    //함수가 끝나기 전에 boardModel 이 채워지지 않음
    //함수가 끝남
    //return boardModel = nil
    
    
    
    /* 게시글 삭제 */
    func removeBoard(uid: String)
    {
        rootRef.child("board").child(uid).removeValue()
        let index = boardArray.firstIndex(where: {$0.uid == uid})
        
        if let index = index {
            self.boardArray.remove(at: index)
        } else {
            print("존재하지 않는 게시물")
        }
    }
    
    /* 게시글 수정*/
    func updateBoard(uid: String, title:String, content:String)
    {
        rootRef.child("board").child(uid).updateChildValues([
                        "userId": UserModel.shared.uid,
                        "title":title,
                        "content":content,
                        "modifiedAt":current_date_string,
                        ])
        
        guard let index = boardArray.firstIndex(where:{$0.uid == uid}) else { return }
        
        let boardModel = self.boardArray[index]
        boardModel.title = title
        boardModel.content = content

    }
    
    /* 새 댓글 등록*/
    func postNewReply(boardId:String, content:String)
    {
        let key: String = rootRef.childByAutoId().key!
        let itemRef = rootRef.child("reply").child(key)
        
        let values: [String: Any] = [ "boardId": boardId,
                                      "userId": UserModel.shared.uid,
                                      "content":content,
                                      "createdAt":current_date_string,
                                      "uid": key]
        let replyModel = ReplyModel(uid: key, boardId: boardId, userId: UserModel.shared.uid, content: content, createdAt: current_date_string)
        
        
        self.replyArray.append(replyModel)
        itemRef.setValue(values)
    }
    
    
    
    /* 모든 댓글 가져오기 */
    func getReplys(completion: @escaping (Array<ReplyModel>) -> ()){
        
        rootRef.child("reply").observeSingleEvent(of: .value, with: { snapshot in
            
            var replys: Array<ReplyModel> = Array<ReplyModel>()
            for child in snapshot.children {
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                
                let uid = dataSnapshot?.key ?? ""
                let boardId = item?["boardId"] as? String ?? ""
                let userId = item?["userId"] as? String ?? ""
                let content = item?["content"] as? String ?? ""
                let createdAt = item?["createdAt"] as? String ?? ""
                
                let replyModel = ReplyModel(uid: uid, boardId: boardId, userId: userId, content: content, createdAt: createdAt)
                replys.append(replyModel)
            }
            completion(replys)
        })
    }
    
    
    /* 하나의 댓글 가져오기 */
  /*  func getReply(uid: String, completion: @escaping (ReplyModel?) -> ()){
        
            rootRef.child("reply").child(uid).observeSingleEvent(of: .value) {snapshot in
            let item = snapshot.value as? NSDictionary
            
            let boardId = item?["boardId"] as? String ?? ""
            let userId = item?["userId"] as? String ?? ""
            let content = item?["content"] as? String ?? ""
            let createdAt = item?["createdAt"] as? String ?? ""
            
            completion(ReplyModel(uid: uid, boardId: boardId, userId: userId, content: content, createdAt: createdAt))
        }
    }
 */
    
    
    
    /* 하나의 댓글 조회 */
    func getReply(uid: String) -> ReplyModel {
        return self.replyArray.filter { $0.uid == uid}.first!
    }
    
    
    /* 댓글 삭제 */
    func removeReply(uid: String)
    {
        rootRef.child("reply").child(uid).removeValue()
        
        let index = replyArray.firstIndex(where: {$0.uid == uid})
        
        if let index = index {
            self.replyArray.remove(at: index)
        }
        else{
            print("존재하지 않는 댓글")
        }
    }
    
    
    /* 댓글 수정 */
    func updateReply(uid:String, boardId:String, content:String, createdAt:String)
    {
        let itemRef = rootRef.child("reply").child(uid)
        
        itemRef.updateChildValues(["boardId": boardId,
                                   "userId": UserModel.shared.uid,
                                   "content":content])
    }
    

    /*특정 그룹의 게시글 모두 불러오기*/
    func getBoardsFromGroup(groupUid: String) -> [BoardModel] {
        return boardArray.filter { $0.groupId == groupUid }
    }
    
    /*특정 게시글의 댓글 모두 불러오기*/
    func getReplyModelFromBoard(boardId: String) -> [ReplyModel] {
        return replyArray.filter { $0.boardId == boardId }
    }
    

                                  
}

/*
 게시글 안에 [댓글]
 
 
 
 댓글을 삭제 -> 게시글 안에 댓글목록 에서도 삭제
 
 [게시글]
 
 [댓글]
 
 [그룹]
 
 
 게시글 의 댓글
 
 댓글들 중에 게시글의 uid == 댓글에 boardId
 
 
 
 
 
 
 
 */
