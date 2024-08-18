//
//  AssetDetailsViewModel.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation
import Combine
import UIKit


final class AssetDetailsViewModel: ObservableObject {
    
    //initial data(not used but need for logic consistance. )
    var asset: ContentGroup.Asset?
    
    @Published var state: AssetDetailsView.State = .idl
    
    private(set) var viewEventSubject = PassthroughSubject<AssetDetailsViewEvent, Never>()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Init

    init(){
        bindViewEvents()
    }
    
    // MARK: - Public
    func loadAssetDetails() {
        guard let asset = asset else { return }
        state = .loading
        Task {
            do {
                let assetDetails = try await loadAssetDetails(original: asset)
                
                await MainActor.run {
                    self.state = .loaded(assetDetails)
                }
            } catch {
                await MainActor.run {
                    self.state = .error(error)
                }
            }

        }
    }
    
    // MARK: - Private
    
    private func bindViewEvents() {
        viewEventSubject.sink { [weak self] event in
            switch event {
            case .viewAppear:
                self?.loadAssetDetails()
            }
        }.store(in: &cancellable)
    }
    
    private func loadAssetDetails(original: ContentGroup.Asset) async throws -> AssetDetailsModel {
        try await AssetDetailsAPI.getAssetDetails(asset: original)
    }
}


