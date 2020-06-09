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
        
        let loopConst = 30
        
        for _ in 1...loopConst {
            self.apiLogin()
        }
    }
    
    func apiLogin() {
        let device = Device(id: "0", platform: "iOS", model: "iPhone 11", system: "iOS 13", libraryVersion: "1")
        let external = External(name: "aaabbbccc", value: "eeefffggg")
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
        let device = Device(id: "0", platform: "iOS", model: "iPhone 11", system: "iOS 13", libraryVersion: "1")
        let external = External(name: "aaabbbccc", value: "eeefffggg")
        let requestForSendLogFirst = RequestForSendLog(level: "aaa", module: "moduleiii", file: "filejjj", data: "bbbcccddd xxx \(self.globalCounter)")
        let requestForSendLogSecond = RequestForSendLog(level: "eee", module: "modulekkk", file: "filelll", data: "fffggghhh xxx \(self.globalCounter)")
        let environment = Environment(bundleName: "bundleName", marketingVersion: "marketingVersion", bundleVersion: "bundleVersion", description: "EnvironmentName")
        let counter = 1
        let sendLogRequest = SendLogRequest(device: device, externals: [external], request: [requestForSendLogFirst, requestForSendLogSecond], environment: environment, counter: counter)
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
