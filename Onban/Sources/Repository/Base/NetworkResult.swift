//
//  NetworkResult.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

enum SessionError: Error {
    case statusCodeError
    case pagingError
    case unknownError
}

struct NetworkResult {
    let data: Data?
    let error: SessionError?
    
    init(_ data: Data) {
        self.data = data
        self.error = nil
    }
    
    init(_ error: SessionError) {
        self.data = nil
        self.error = error
    }
}

extension NetworkResult {
    func decode<T: Decodable>(_ type: T.Type) -> ApiResult<T, SessionError> {
        guard error == nil else {
            return ApiResult(value: nil, error: error)
        }
        
        guard let data = data,
              let decodableData = try? JSONDecoder().decode(T.self, from: data)
        else {
            return ApiResult(value: nil, error: .pagingError)
        }
        return ApiResult(value: decodableData, error: nil)
    }
}
