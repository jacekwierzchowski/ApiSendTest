//
//  SendLogRequest.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct SendLogRequest: Codable {
    let device: Device
    let externals: [External]
    let request: [RequestForSendLog]
    let environment: Environment
    let counter: Int
}

struct RequestForSendLog: Codable {
    let level: String
    let data: String
}
