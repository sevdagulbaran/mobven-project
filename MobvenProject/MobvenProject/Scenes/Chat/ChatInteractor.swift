//
//  ChatInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 11.04.2023.
//

import Foundation

protocol ChatBusinessLogic: AnyObject {
    
}

protocol ChatDataStore: AnyObject {
    
}

final class ChatInteractor: ChatBusinessLogic, ChatDataStore {
    
    var presenter: ChatPresentationLogic?
    var worker: ChatWorkingLogic = ChatWorker()
    
}
