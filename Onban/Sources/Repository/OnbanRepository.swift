//
//  OnbanRepository.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

protocol OnbanRepository {
    func requestItems(_ type: CategoryType) async throws -> ApiResult<[DishDTO], SessionError>
    func requestDetail(_ detailHash: String) async throws -> ApiResult<DetailDishDTO, SessionError>
}

final class OnbanRepositoryImpl: NetworkRepositroy<OnbanAPI>, OnbanRepository {
    
    func requestItems(_ type: CategoryType) async throws -> ApiResult<[DishDTO], SessionError> {
        let receive = try await request(type.api)
        let category = receive?.decode(CategoryDTO.self)
        
        if let dishes = category?.value?.body {
            return ApiResult(value: dishes, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
    
    func requestDetail(_ detailHash: String) async throws -> ApiResult<DetailDishDTO, SessionError> {
        let receive = try await request(.requestDetail(datailHash: detailHash))
        let response = receive?.decode(DetailResponse.self)
        if let detailDish = response?.value?.data {
            return ApiResult(value: detailDish, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }

}
