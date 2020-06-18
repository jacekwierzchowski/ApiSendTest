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
    let enviroment: Enviroment
    let counter: Int
}

struct RequestForSendLog: Codable {
    let level: String
    let module: String
    let file: String
    let data: String
}
