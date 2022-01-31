//
//  AppTabView.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/30/22.
//

import SwiftUI

// MARK: - Custom Tab View
struct AppTabView<Content: View>: View {
    let tabs: [TabItemModel]
        @Binding var selectedIndex: Int
        @ViewBuilder let content: (Int) -> Content

    //Use @ViewBuilder to mark our content closure.
    //It gives us the opportunity to use AppTabView in the same way as VStack or HStack.
        
        var body: some View {
            ZStack {
                TabView(selection: $selectedIndex) {
                    ForEach(tabs.indices) { index in
                        content(index)
                            .tag(index)
                    }
                }.background(.clear)
                
                VStack {
                    Spacer()
                    TabContentView(tabbarItems: tabs, selectedIndex: $selectedIndex)
                }
                .padding(.bottom, 8)
            }
        }
}

//struct AppTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabContentView()
//    }
//}


struct TabItemModel {
    let image: String
    let selectedImage: String?
    let title: String
}

// MARK: - Tab Item
struct TabItemView: View {
    let data: TabItemModel
    let isSelected: Bool
    let width = 32.0, height: CGFloat = 32.0 //TBD:- Need to use Geomatry for dynamic size
    
    var body: some View {
        VStack {
            Image(systemName: data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .foregroundColor(isSelected ? .green : .gray)
                .animation(.easeInOut, value: false)
            
            Spacer().frame(height: 4)
            
            Text(data.title)
                .foregroundColor(isSelected ? .green : .gray)
                .font(.system(size: 14))
        }
    }
}

// MARK: - Tab View
struct TabContentView: View {
    
    let tabbarItems: [TabItemModel]
    var height: CGFloat = 70
    var width: CGFloat = UIScreen.main.bounds.width - 32
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabbarItems.indices) { index in
                let item = tabbarItems[index]
                Button {
                    self.selectedIndex = index
                } label: {
                    let isSelected = selectedIndex == index
                    TabItemView(data: item, isSelected: isSelected)
                }
                Spacer()
            }
        }
        .frame(width: width, height: height)
        .background(Color.white)
        .cornerRadius(13)
        .shadow(radius: 5, x: 0, y: 4)
    }
}
