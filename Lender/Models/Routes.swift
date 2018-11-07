//
//  Routes.swift
//  Lender
//
//  Created by Atomo on 11/7/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation

class Routes {
    
    func postLoan(loan: Loan, completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "placeholdersite.com"
        urlComponents.path = "/make_loan_request"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(loan)
            request.httpBody = jsonData
        } catch {
            completion?(error)
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    //Post the passed in User struct to /user_creation
    func postUser(user: User, completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "placeholdersite.com"
        urlComponents.path = "/user_creation"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            completion?(error)
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
}
