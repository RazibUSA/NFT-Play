//
//  nftPlayApp.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import SwiftUI

@main
struct nftPlayApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    // MARK: - Start The App
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .active:
                print("View is now active!")
            case .inactive:
                print("View is now inactive!")
            case .background:
                print("View is now in the background!")
            @unknown default:
                print("Something new!")
            }
        }
    }
}
