//
//  Example.swift
//  FluidSideBar
//
//  Created by Bruna on 12/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        ElegantTabView(position: .right, selectedTab: $selectedTab) {
            HomeScreen()
                .tabItem("house")
            
            SearchScreen()
                .tabItem("magnifyingglass")
            
            ProfileScreen()
                .tabItem("person")
            
            SettingsScreen()
                .tabItem("gearshape")
        }
        .background(Color.blue)
    }
}

struct HomeScreen: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
            Text("Home Screen")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
}

struct SearchScreen: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)
            Text("Search Screen")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
}

struct ProfileScreen: View {
    var body: some View {
        ZStack {
            Color.orange.opacity(0.2).edgesIgnoringSafeArea(.all)
            Text("Profile Screen")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
}

struct SettingsScreen: View {
    var body: some View {
        ZStack {
            Color.purple.opacity(0.2).edgesIgnoringSafeArea(.all)
            Text("Settings Screen")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
}
