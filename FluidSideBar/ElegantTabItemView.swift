//
//  ElegantTabItemView.swift
//  FluidSideBar
//
//  Created by Bruna on 12/10/2024.
//

import SwiftUI

struct ElegantTabItemView: View {
    let iconName: String
    let tag: Int
    let content: AnyView
    
    static var nextTag = 0
    
    init(iconName: String, content: AnyView) {
        self.iconName = iconName
        self.content = content
        self.tag = ElegantTabItemView.nextTag
        ElegantTabItemView.nextTag += 1
    }
    
    var body: some View {
        content
    }
}

extension View {
    func tabItem(_ iconName: String) -> ElegantTabItemView {
        ElegantTabItemView(iconName: iconName, content: AnyView(self))
    }
}
