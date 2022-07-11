//
//  DatabaseManager.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import Foundation

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
}

extension DatabaseManager {
    
    //create a new converation with a target user
    func createNewConversation(with otherUserEmail: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        
    }
    
    //fetches and returns all conversations
    func getAllConversations(for email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    func getAllMessagesForConversation(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    //send a message with target conversation and message
    func sendMessage(to conversation: String, message: Message, completion: @escaping (Bool) -> Void) {
        
    }
}
