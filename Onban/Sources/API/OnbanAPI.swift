//
//  OnbanAPI.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation
import UIKit

enum OnbanAPI {
    case requestMainDish
    case requestSideDish
    case requestSoup
    case requestDetail(datailHash: String)
    case requestPayment(order: Payload)
}

extension OnbanAPI: BaseAPI {
    var baseURL: URL {
        switch self {
        case .requestPayment:
            guard let filePath = Bundle.main.path(forResource: "Api", ofType: "plist"),
                  let resource = NSDictionary(contentsOfFile: filePath),
                  let url = resource["API_URL"] as? String
            else { assert(false) }

            return URL(string: url)!
        default:
            return URL(string: "https://api.codesquad.kr/onban/")!
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestDetail, .requestMainDish, .requestPayment, .requestSideDish, .requestSoup:
            return nil
        }
    }
    
    var path: String? {
        switch self {
        case .requestMainDish:
            return "/main"
        case .requestSideDish:
            return "/side"
        case .requestSoup:
            return "/soup"
        case .requestDetail(let detailHash):
            return "/detail/\(detailHash)"
        case .requestPayment:
            return nil
        }
    }
    
    // TODO: - Body 사용법 학습 필요
    var body: Data? {
        switch self {
        case .requestPayment(let payload):
            let thing = "payload={\"channel\": \"#모바일ios-generic\", \"username\": \"\(payload.userName)\", \"text\": \"\(payload.text)\", \"icon_emoji\": \":ghost:\"}"
            return thing.data(using: .utf8)
            
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .requestPayment:
            return "POST"
        default:
            return "GET"
        }
    }
    
}
