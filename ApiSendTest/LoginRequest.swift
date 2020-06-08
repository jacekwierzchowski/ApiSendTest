//
//  LoginRequest.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

struct LoginRequest: Codable {
    let device: Device
    let externals: [External]
    let request: RequestForLogin
}

struct RequestForLogin: Codable {
    let id: String
    let password: String
}
