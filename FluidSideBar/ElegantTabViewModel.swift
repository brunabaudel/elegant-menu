//
//  ElegantTabViewModel.swift
//  FluidSideBar
//
//  Created by Bruna on 12/10/2024.
//

import SwiftUI

enum TabbarPosition {
    case left, bottom, right
}

extension ElegantTabView {
    func background(_ color: Color) -> Self {
        var view = self
        view.tabBarBackgroundColor = color
        return view
    }
    func findTabItems(in mirror: Mirror) -> [ElegantTabItemView] {
        var tabItems: [ElegantTabItemView] = []
        
        for child in mirror.children {
            if let tabItem = child.value as? ElegantTabItemView {
                tabItems.append(tabItem)
            } else {
                let childMirror = Mirror(reflecting: child.value)
                tabItems.append(contentsOf: findTabItems(in: childMirror))
            }
        }
        
        return tabItems
    }
    
    @ViewBuilder
    func tabbarView(geometry: GeometryProxy) -> some View {
        switch position {
        case .left:
            HStack {
                tabbarContent(geometry: geometry)
                    .frame(width: 70)
                    .padding(4)
                    
                Spacer()
            }
        case .bottom:
            VStack {
                Spacer()
                tabbarContent(geometry: geometry)
                    .frame(height: 70)
                    .padding(4)
                    
            }
        case .right:
            HStack {
                Spacer()
                tabbarContent(geometry: geometry)
                    .frame(width: 70)
                    .padding(4)
            }
        }
    }
    
    func tabbarContent(geometry: GeometryProxy) -> some View {
        ZStack {
            Group {
                if position == .bottom {
                    HStack(spacing: 0) {
                        tabButtons
                    }
                } else {
                    VStack(spacing: 0) {
                        tabButtons
                    }
                }
            }
            .padding(.vertical, position == .bottom ? 5 : 15)
            .padding(.horizontal, position == .bottom ? 15 : 5)
            .background(tabBarBackgroundColor)
            .clipShape(Capsule())
            
            indicatorCircle(geometry: geometry)
        }
    }
    
    var tabButtons: some View {
        ForEach(0..<tabs.count, id: \.self) { index in
            ElegantTabViewButtonView(
                title: tabs[index],
                isSelected: selectedTab == index,
                position: position,
                action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = index
                    }
                },
                tabPosition: $tabPositions[index]
            )
        }
    }
    
    func indicatorCircle(geometry: GeometryProxy) -> some View {
        Circle()
            .trim(from: 0, to: 0.5)
            .fill(Color.white)
            .frame(width: 30, height: 30)
            .rotationEffect(indicatorRotation)
            .offset(indicatorOffset(geometry: geometry))
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
    }
    
    var indicatorRotation: Angle {
        switch position {
        case .left:
            return .degrees(90)
        case .bottom:
            return .degrees(0)
        case .right:
            return .degrees(-90)
        }
    }
    
    func indicatorOffset(geometry: GeometryProxy) -> CGSize {
        switch position {
        case .left:
            return CGSize(width: 35, height: tabPositions[selectedTab] - geometry.size.height / 2 - 18)
        case .bottom:
            return CGSize(width: tabPositions[selectedTab] - geometry.size.width / 2 + 33, height: -35)
        case .right:
            return CGSize(width: -35, height: tabPositions[selectedTab] - geometry.size.height / 2 - 18)
        }
    }
}
