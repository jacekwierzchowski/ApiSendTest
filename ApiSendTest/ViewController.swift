//
//  ViewController.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var globalCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loopConst = 1
        
        for _ in 1...loopConst {
            self.apiLogin()
        }
    }
    
    func apiLogin() {
        let device = Device(id: "5B6C6179-F6B5-4A81-989A-53535D3F0F1F", platform: "iOS", model: "iPhone X", system: "13.5.1", libraryVersion: "1.0")
        let external = External(name: "bundle-id", value: "com.softax.mobile.PeoPay25.PublicTest")
        let request = RequestForLogin(id: "7q2enMKu-d9pH0Z1W-tKge-hFjW3Mnq-1cFW-sv0G8zYb-ydGp3v9m", password: "4dobGxXz78OY")
        let loginRequest = LoginRequest(device: device, externals: [external], request: request)
        if let url = URL(string: "http://localhost:8080/api/login") {
            let encoder = JSONEncoder()
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("pl-pl", forHTTPHeaderField: "Accept-Language")
            request.setValue("utf-8", forHTTPHeaderField: "Accept-Charset")
            request.httpBody = try? encoder.encode(loginRequest)
            print("---------------------------------------------------")
            print("POST to: \(request)")
            if let allHeaders = request.allHTTPHeaderFields {
                for header in allHeaders {
                    print("\(header.key): \(header.value)")
                }
            }
            if let httpBody = request.httpBody, let jsonBody = httpBody.prettyPrintedJSONString {
                print(jsonBody)
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("---------------------------------------------------")
                        print("Reply from: \(request)")
                        print(jsonResponse)
                        let json = jsonResponse as? [String: [String: Any]]
                        if let jsonReply = json?["reply"],
                            let jsonToken = jsonReply["token"],
                            let jsonTokenString = jsonToken as? String {
                            self.apiSendLog(token: jsonTokenString)
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }.resume()
        }
    }
    
    func apiSendLog(token: String?) {
        self.globalCounter += 1
        let device = Device(id: "5B6C6179-F6B5-4A81-989A-53535D3F0F1F", platform: "iOS", model: "iPhone X", system: "13.5.1", libraryVersion: "1.0")
        let external = External(name: "bundle-id", value: "com.softax.mobile.PeoPay25.PublicTest")
        let requestForSendLogFirst = RequestForSendLog(level: "info", module: "GENERAL", file: "SessionModel.swift:126:tickTimer()", data: "VGltZXI6IDYwMCAxMA==")
        let requestForSendLogSecond = RequestForSendLog(level: "info", module: "GENERAL", file: "SessionModel.swift:126:tickTimer()", data: "VGltZXI6IDYwMCAxNQ==")
        let requestForSendLogThird = RequestForSendLog(level: "info", module: "GENERAL", file: "SessionModel.swift:126:tickTimer()", data: "VGltZXI6IDYwMCAyMA==")
        let enviroment = Enviroment(bundleName: "com.softax.mobile.PeoPay25.PublicTest", marketingVersion: "5", bundleVersion: "UNKNOWN", description: "PUBLICTEST")
        let counter = 12
        let sendLogRequest = SendLogRequest(device: device, externals: [external], request: [requestForSendLogFirst, requestForSendLogSecond, requestForSendLogThird], enviroment: enviroment, counter: counter)
        if let url = URL(string: "http://localhost:8080/api/send_log") {
            let encoder = JSONEncoder()
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("pl-pl", forHTTPHeaderField: "Accept-Language")
            request.setValue("utf-8", forHTTPHeaderField: "Accept-Charset")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.httpBody = try? encoder.encode(sendLogRequest)
            print("----------------------------------------------")
            print("POST to: \(request)")
            if let allHeaders = request.allHTTPHeaderFields {
                for header in allHeaders {
                    print("\(header.key): \(header.value)")
                }
            }
            if let httpBody = request.httpBody, let jsonBody = httpBody.prettyPrintedJSONString {
                print(jsonBody)
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("----------------------------------------------")
                        print("Reply from: \(request)")
                        print(jsonResponse)
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }.resume()
        }
    }
    
}
