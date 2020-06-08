//
//  Device.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct Device: Codable {
    var id: String
    var platform: String
    var model: String
    var system: String
    var libraryVersion: String
}
