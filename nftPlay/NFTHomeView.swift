//
//  NFTHomeView.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import SwiftUI

struct NFTHomeView: View {
    
    @ObservedObject var viewModel: NFTHomeViewModel
    
    init(viewModel: NFTHomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.collectionList) { nft in
                        HStack {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: nft.bannerImageURL!)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 200, height: 200)
                                Text(nft.name)
                                    .font(.headline)
                                Text(nft.slug)
                                    .font(.subheadline)
                            }
                        }.padding(25)
                            .background(Rectangle().fill(Color.white))
                            .cornerRadius(12)
                            .shadow(color: .gray, radius: 3, x: 2, y: 2)
                        
                    }
                    
                }.frame(maxWidth: .infinity)
                    .onAppear(perform: {
                    viewModel.getNFTCollection()
                })
                
                .navigationTitle("OpenSea NFT:")
            }.frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
        }
            
    }
}

//struct NFTHomeView_Previews: PreviewProvider {
//    let nftaPI = OpenSeaAPI()
//    let homeViewModel = NFTHomeViewModel(openSeaAPI: nftaPI, offset: 0, limit: 50)
//    static var previews: some View {
//        NFTHomeView(viewModel: <#NFTHomeViewModel#>)
//    }
//}

// MARK: - Mock data
//============= MOCK TEST DATA ======================
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let slug: String
    let bannerImageURL: String
}

extension Item {
    static var testData: [Item] {
            return [
            Item(name: "Harami 1", slug: "Harami2", bannerImageURL: "https://lh3.googleusercontent.com/JB6vZxAQJwNuDk6HDggPisur1oUUusNDZBniZxvGIeWHRNBTO669aLE4FwbHnea18H47vnABELg2e48288RtMzuk4D3Rc5vudlbu=s120"),
            Item(name: "Harami Ok", slug: "Harami2", bannerImageURL: "https://lh3.googleusercontent.com/Vo5FgVUDscVI0_uN7Xr7ShIvyT-nLRlrfX7oSXMkOORYI02uNYid-Lk9XfG-axoVa8eAiJ67f3rhdNI23x_9JIJSepVIHQo_A9UBAA=s300")
            
            ]
    
    
    }
}
