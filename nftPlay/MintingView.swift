//
//  MintingView.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/30/22.
//

import SwiftUI

// MARK: - Mint
// TBD:- Working in local
struct MintingView: View {
    @State private var offset: CGFloat = 200.0
        var body: some View {
            VStack {
                Image("sweet")
                    .font(Font.system(size: 50.0))
                    .offset(y: -200)
                    .shadow(radius: 10.0)
                Text("Minting is coming soon.")
                    .foregroundColor(.green)
                Image(systemName: "ant")
                    .font(Font.system(size: 50.0))
                    .offset(y: offset)
                    .shadow(radius: 10.0)
                    .onTapGesture { offset -= 70.0 }
                    .animation(Animation.easeInOut(duration: 1.0), value: offset)
                    .foregroundColor(.red)
            }
        }
}

struct MintingView_Previews: PreviewProvider {
    static var previews: some View {
        MintingView()
    }
}





