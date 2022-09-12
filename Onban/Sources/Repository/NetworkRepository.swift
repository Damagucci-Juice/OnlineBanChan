//
//  NetworkRepository.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

class NetworkRepositroy<API: BaseAPI> {
    private var provider: URLSessionProvider?
    
    func request(_ target: API, session: URLSessionProtocol = URLSession.shared) async throws -> NetworkResult? {
        provider = URLSessionProvider(session: session)
        var url = target.baseURL
        if let path = target.path {
            url = url.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method
        if let body = target.body {
            let json = try JSONSerialization.data(withJSONObject: body, options: [])
            urlRequest.httpBody = json
        }
        
        return try await provider?.dataTask(request: urlRequest)
    }
}
