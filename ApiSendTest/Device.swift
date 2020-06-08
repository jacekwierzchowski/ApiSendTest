//
//  Device.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct Device: Codable {
    let id: String
    let platform: String
    let model: String
    let system: String
    let libraryVersion: String
}
