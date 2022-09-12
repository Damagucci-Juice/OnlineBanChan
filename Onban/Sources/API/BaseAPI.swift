//
//  BaseAPI.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

protocol BaseAPI {
    var baseURL: URL { get }
    var parameter: [String: Any]? { get }
    var path: String? { get }
    var method: String { get }
    var body: [String: Any]? { get }
}
