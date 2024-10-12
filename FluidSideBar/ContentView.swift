import SwiftUI

struct FluidTabbarMenu: View {
    @State private var selectedTab = 0
    @State private var tabPositions: [CGFloat] = [0, 0, 0, 0]
    
    let tabs = ["house", "magnifyingglass", "person", "gearshape"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Main content area
                ZStack {
                    switch selectedTab {
                    case 0:
                        HomeScreen()
                    case 1:
                        SearchScreen()
                    case 2:
                        ProfileScreen()
                    case 3:
                        SettingsScreen()
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Tabbar
                ZStack(alignment: .bottom) {
                    Color.clear.ignoresSafeArea()
                    
                    HStack(spacing: 0) {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            TabbarButton(
                                title: tabs[index],
                                isSelected: selectedTab == index,
                                action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedTab = index
                                    }
                                },
                                position: $tabPositions[index]
                            )
                        }
                    }
                    .padding(.horizontal, 15)
                    .background(.black)
                    .clipShape(Capsule())
                    
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .offset(x: tabPositions[selectedTab] - geometry.size.width / 2 + 41, y: -45)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct TabbarButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    @Binding var position: CGFloat
    
    var body: some View {
        Button(action: action) {
            Image(systemName: title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(isSelected ? .white : .gray)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
        }
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: TabPositionKey.self, value: geo.frame(in: .global).minX)
            }
        )
        .onPreferenceChange(TabPositionKey.self) { position = $0 }
    }
}

struct TabPositionKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
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

struct ContentView: View {
    var body: some View {
        FluidTabbarMenu()
    }
}
