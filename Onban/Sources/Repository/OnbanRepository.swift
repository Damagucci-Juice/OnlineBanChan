//
//  OnbanRepository.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

protocol OnbanRepository {
    func reqeuestMain() async throws -> ApiResult<[DishDTO], SessionError>
    func reqeuestSide() async throws -> ApiResult<[DishDTO], SessionError>
    func reqeuestSoup() async throws -> ApiResult<[DishDTO], SessionError>
}

// TODO: - main, side, soup 이것을 Main 하나로 통합할 순 없을까?
final class OnbanRepositoryImpl: NetworkRepositroy<OnbanAPI>, OnbanRepository {
    func reqeuestMain() async throws -> ApiResult<[DishDTO], SessionError> {
        let receive = try await request(.requestMainDish)
        let apiResult = receive?.decode(CategoryDTO.self)
        if let mains = apiResult?.value?.body {
            return ApiResult(value: mains, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
    
    func reqeuestSide() async throws -> ApiResult<[DishDTO], SessionError> {
        let receive = try await request(.requestSideDish)
        let apiResult = receive?.decode(CategoryDTO.self)
        if let sides = apiResult?.value?.body {
            return ApiResult(value: sides, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
    
    func reqeuestSoup() async throws -> ApiResult<[DishDTO], SessionError> {
        let receive = try await request(.requestSoup)
        let apiResult = receive?.decode(CategoryDTO.self)
        if let soups = apiResult?.value?.body {
            return ApiResult(value: soups, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
}
