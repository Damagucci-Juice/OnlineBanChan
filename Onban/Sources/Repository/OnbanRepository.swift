//
//  OnbanRepository.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

protocol OnbanRepository {
    func requestOnbanApi(_ type: CategoryType) async throws -> ApiResult<[DishDTO], SessionError>
//    func requestMain() async throws -> ApiResult<[DishDTO], SessionError>
//    func requestSoup() async throws -> ApiResult<[DishDTO], SessionError>
//    func requestSide() async throws -> ApiResult<[DishDTO], SessionError>
}

final class OnbanRepositoryImpl: NetworkRepositroy<OnbanAPI>, OnbanRepository {
    
    func requestOnbanApi(_ type: CategoryType) async throws -> ApiResult<[DishDTO], SessionError> {
        let receive = try await request(type.api)
        let category = receive?.decode(CategoryDTO.self)
        
        if let dishes = category?.value?.body {
            return ApiResult(value: dishes, error: nil)
        } else {
            return ApiResult(value: nil, error: .unknownError)
        }
    }
    
//    func requestSoup() async throws -> ApiResult<[DishDTO], SessionError> {
//        let receive = try await request(.requestSoup)
//        let category = receive?.decode(CategoryDTO.self)
//
//        if let dishes = category?.value?.body {
//            return ApiResult(value: dishes, error: nil)
//        } else {
//            return ApiResult(value: nil, error: .unknownError)
//        }
//    }
//
//    func requestSide() async throws -> ApiResult<[DishDTO], SessionError> {
//        let receive = try await request(.requestSideDish)
//        let category = receive?.decode(CategoryDTO.self)
//
//        if let dishes = category?.value?.body {
//            return ApiResult(value: dishes, error: nil)
//        } else {
//            return ApiResult(value: nil, error: .unknownError)
//        }
//    }
//
//    func requestMain() async throws -> ApiResult<[DishDTO], SessionError> {
//        let receive = try await request(.requestMainDish)
//        let category = receive?.decode(CategoryDTO.self)
//
//        if let dishes = category?.value?.body {
//            return ApiResult(value: dishes, error: nil)
//        } else {
//            return ApiResult(value: nil, error: .unknownError)
//        }
//    }
//
}
