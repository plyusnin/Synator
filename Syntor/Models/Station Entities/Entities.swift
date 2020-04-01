//
//  Entities.swift
//  Syntor
//
//  Created by Евгений Плюснин on 31.03.2020.
//  Copyright © 2020 Evgenii Pliusnin. All rights reserved.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T
    let success: Bool
}

struct AuthorizationData: Decodable {
    let sid: String
}

struct TaskListData: Decodable {
    let total: Int
    let offset: Int
    let tasks: [TaskData]
    
    struct TaskData: Decodable {
        let id: String
        let title: String
    }
    
    struct TaskAdditionalData: Decodable {
        let transfer: TaskTransferData
    }
    
    struct TaskTransferData: Decodable {
        let size_downloaded: String
        let size_uploaded: String
        let speed_download: Int
        let speed_uploaded: Int
    }
}
