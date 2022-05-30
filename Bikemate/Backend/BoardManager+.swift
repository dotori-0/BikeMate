//
//  BoardManager+.swift
//  Bikemate
//
//  Created by 박진서 on 2022/03/08.
//

import FirebaseDatabase

extension BoardManager {
    

    /* 새 댓글 등록*/
    func postNewReplyReturnModel(boardId:String, content:String, current:String) -> ReplyModel
    {
        let ref = Database.database().reference()
        let key: String = ref.childByAutoId().key!
        let itemRef = ref.child("reply").child(key)
        
        let values: [String: Any] = [ "boardId": boardId,
                                      "userId": UserModel.shared.uid,
                                      "content":content,
                                      "createdAt": current,
                                      "uid": key]
        let replyModel = ReplyModel(uid: key, boardId: boardId, userId: UserModel.shared.uid, content: content, createdAt: current)
        
        
        self.replyArray.append(replyModel)
        itemRef.setValue(values)
        
        return replyModel
    }
    
}
