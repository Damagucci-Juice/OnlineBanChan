//
//  OnbanRepository.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

protocol OnbanRepository {
    func reqeuestMain() async throws -> ApiResult<[[DishDTO]], SessionError>
}

final class OnbanRepositoryImpl: NetworkRepositroy<OnbanAPI>, OnbanRepository {
    func reqeuestMain() async throws -> ApiResult<[[DishDTO]], SessionError> {
        let mainReceive = try await request(.requestMainDish)
        let soupReceive = try await request(.requestSoup)
        let sideReceive = try await request(.requestSideDish)
        
        let results: [[DishDTO]] = [mainReceive, soupReceive, sideReceive].compactMap { receive in
            let result = receive?.decode(CategoryDTO.self)
            return result?.value?.body
        }
        
        if results.count == 3 {
            return ApiResult(value: results, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
}
