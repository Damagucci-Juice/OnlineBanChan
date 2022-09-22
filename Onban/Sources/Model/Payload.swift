//
//  Payload.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/21.
//

import Foundation

struct Payload: Codable {
    let channel: String
    let userName: String
    let text: String
    let iconEmoji: String

    enum CodingKeys: String, CodingKey {
        case iconEmoji = "icon_emoji"
        case userName = "username"
        case channel, text
    }
}
