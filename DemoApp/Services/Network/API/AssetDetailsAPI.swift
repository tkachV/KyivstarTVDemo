//
//  AssetDetailsAPI.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation

final class AssetDetailsAPI: BaseAPI {
    
    static func getAssetDetails(asset: ContentGroup.Asset) async throws -> AssetDetailsModel {
        var request = GenericRequest(withMethod: .get, path: "templates/04Pl5AYhO6-n/data")
        //will be some specific id from asset model.
        request.authenticated = true

        return try await perform(request: request)
    }
}
