//
//  MainCoordinator.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import Foundation
import SwiftUI

// MARK: - Tab Item
enum TabType: Int, CaseIterable {
    case mint = 0
    case home
    case augment
    
    var tabItem: TabItemModel {
        switch self {
        case .mint:
            return TabItemModel(image: "number", selectedImage: nil, title: "Mint")
        case .home:
            return TabItemModel(image: "snowflake", selectedImage: nil, title: "Home")
        case .augment:
            return TabItemModel(image: "cube", selectedImage: nil, title: "View")
        }
    }
}

// MARK: - Manage View
public struct MainCoordinator: Coordinator {
    var factory: AppViewFactory = AppViewFactory()
    @State var selectedIndex: Int = 1
    
        init() {
            UITabBar.appearance().isHidden = true
        }
        
       public var body: some View {
           AppTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
                let type = TabType(rawValue: index) ?? .home
                getTabView(type: type)
            }
        }
        
        @ViewBuilder
        func getTabView(type: TabType) -> some View {
            switch type {
            case .mint:
                AnyView(factory.mintView())
            case .home:
                AnyView(factory.nftHomeView())
            case .augment:
                AnyView(factory.augmentView())
            }
        }
}


struct AppViewFactory {

    func nftHomeView() -> some View {
        let nftaPI = OpenSeaAPI()
        let homeViewModel = NFTHomeViewModel(openSeaAPI: nftaPI, offset: 0, limit: 50)
        return NFTHomeView(viewModel: homeViewModel)
    }
    
    func mintView() -> some View {
        return MintingView()
    }

    func augmentView() -> some View {
        return AugmentedView(cards: NFTItem.testData)
    }
}
