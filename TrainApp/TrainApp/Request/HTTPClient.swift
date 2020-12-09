//
//  HTTPClient.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import PromiseKit

class HTTPClient: NSObject {
    static let sharedInstance = HTTPClient()
    
    func get(route: HTTPRouter.Routes, parameters: [String: String]? = nil) -> Promise<Data> {
        var urlString = route.urlString
        if let parameters = parameters {
            for (index, parameter) in parameters.enumerated() {
                urlString += "\(parameter.key)=\(parameter.value)"
                if index < parameters.count {
                    urlString += "&"
                }
            }
        }
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("text/xml", forHTTPHeaderField: "Accept")
        return self.httpOperation(request: request, route: route)
    }
    
    private func httpOperation(request: URLRequest, route: HTTPRouter.Routes) -> Promise<Data> {
        return Promise<Data> { seal in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    seal.reject(RequestError.invalidResponse)
                    return
                }
                guard response.statusCode <= 200 || response.statusCode > 300 else {
                    seal.reject(RequestError.invalidStatusCode)
                    return
                }
                guard let data = data else {
                    seal.reject(RequestError.noData)
                    return
                }
                seal.fulfill(data)
            }.resume()
        }
    }
    
}

enum RequestError: LocalizedError {
    case invalidResponse
    case invalidStatusCode
    case noData
}
