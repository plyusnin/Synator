//
//  Entities.swift
//  Syntor
//
//  Created by Евгений Плюснин on 31.03.2020.
//  Copyright © 2020 Evgenii Pliusnin. All rights reserved.
//

import Foundation

struct AuthorizationResponse: Decodable {
    let data: AuthorizationData
    let success: Bool
    
    struct AuthorizationData: Decodable {
        let sid: String
    }
}
