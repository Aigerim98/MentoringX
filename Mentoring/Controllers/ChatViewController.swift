//
//  ChatViewController.swift
//  Mentoring
//
//  Created by Айгерим Абдурахманова on 09.07.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {

    let currentUser = Sender(senderId: "self", displayName: "Mentoring")
    let otherUser = Sender(senderId: "other", displayName: "Aigerim")
    
    var messages = [MessageType]()
    var isNewConversation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello world")))
//        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-66400), kind: .text("Hello world")))
//        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-76400), kind: .text("Hello world")))
//        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-56400), kind: .text("Hello world")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: " ").isEmpty else { return }
        
        //Send message
        if isNewConversation {
            // create convo in database
            
            let message = Message(sender: currentUser, messageId: otherUser.senderId, sentDate: Date(), kind: .text(text))
            messages.append(message)
            //DatabaseManager.shared.createNewConversation(with: <#T##String#>, firstMessage: <#T##Message#>, completion: <#T##(Bool) -> Void#>)
        }else {
            //append to existing data
        }
    }
}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {

    func currentSender() -> SenderType {
        return currentUser
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

}

