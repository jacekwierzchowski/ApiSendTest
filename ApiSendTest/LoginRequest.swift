//
//  LoginRequest.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct LoginRequest: Codable {
    var device: Device
    var externals: [External]
    var request: RequestForLogin
}

struct RequestForLogin: Codable {
    var id: String
    var password: String
}
