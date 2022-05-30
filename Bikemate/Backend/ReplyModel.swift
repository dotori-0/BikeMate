//
//  ReplyModel.swift
//  Bikemate
//
//  Created by new on 2022/02/17.
//

import Foundation


//댓글 

class ReplyModel{
    
    public let uid: String
    public let boardId: String
    public let userId: String
    public let content: String
    public let createdAt: String
    
    
    public init(uid: String, boardId: String, userId: String, content: String, createdAt: String)
    {
        self.uid = uid
        self.boardId = boardId
        self.userId = userId
        self.content = content
        self.createdAt = createdAt
    }
}


// 평균 주행 거리, 속도,, 시간 ... m 를 km
