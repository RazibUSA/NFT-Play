//
//  NFTHomeViewModel.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import Foundation
import SwiftUI
import Combine

class NFTHomeViewModel: ObservableObject {
    
    @Published var collectionList: [Collection] = []
    
    private let nftInteractor: OpenSeaAPI
    private var offset: Int, limit: Int
    private var cancellable = Set<AnyCancellable>()
    
    init(openSeaAPI: OpenSeaAPI, offset: Int, limit: Int) {
        self.nftInteractor = openSeaAPI
        self.offset = offset
        self.limit = limit
    }
    
    func getNFTCollection() {
        nftInteractor.getCollection(offset: offset, limit: limit)
            .mapError ({ (error) -> Error in
                print(error)
                return error
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                print("Complete")
            }, receiveValue: { [weak self] val in
                    self?.collectionList = val.collections.filter({$0.bannerImageURL != nil})
            })
            .store(in: &cancellable)
    }
}

