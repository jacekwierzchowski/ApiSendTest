//
//  ViewController.swift
//  ApiSendTest
//
//  Created by Jacek Wierzchowski on 08/06/2020.
//  Copyright © 2020 Jacek Wierzchowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiLogin()
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
            print("----------------------------------------------")
            print("Reply from: \(request)")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponse)
                        let json = jsonResponse as? [String: [String: Any]]
                        if let jsonReply = json?["reply"],
                            let jsonToken = jsonReply["token"],
                            let jsonTokenString = jsonToken as? String {
                            self.token = jsonTokenString
                            self.apiSendLog(token: self.token)
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }.resume()
        }
    }
    
    func apiSendLog(token: String?) {
        let device = Device(id: "0", platform: "iOS", model: "iPhone 11", system: "iOS 13", libraryVersion: "1")
        let external = External(name: "aaabbbccc", value: "eeefffggg")
        let requestForSendLogFirst = RequestForSendLog(level: "aaa", data: "bbbcccddd")
        let requestForSendLogSecond = RequestForSendLog(level: "eee", data: "fffggghhh")
        let environment = "Test"
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
            print("----------------------------------------------")
            print("Reply from: \(request)")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponse)
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }.resume()
        }
    }
    
}
