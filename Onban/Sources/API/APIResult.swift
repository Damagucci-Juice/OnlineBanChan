//
//  APIResult.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

struct ApiResult<T, Error: Swift.Error> {
    private(set) var value: T?
    private(set) var error: Error?
}
