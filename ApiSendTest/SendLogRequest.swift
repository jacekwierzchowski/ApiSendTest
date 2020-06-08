//
//  SendLogRequest.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct SendLogRequest: Codable {
    var device: Device
    var externals: [External]
    var request: [RequestForSendLog]
    var environment: String
    var counter: Int
}

struct RequestForSendLog: Codable {
    var level: String
    var data: String
}
