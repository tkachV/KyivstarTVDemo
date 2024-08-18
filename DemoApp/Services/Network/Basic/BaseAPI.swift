//
//  BaseAPI.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

class BaseAPI {

    static func perform<T: Decodable>(request: GenericRequest) async throws -> T {
        return try await NetworkServiceProviderImpl.shared.perform(request)
    }

    //static func performMultipartFormData
}
