import SwiftUI

struct ElegantTabView<Content: View>: View {
    let position: TabbarPosition
    @Binding var selectedTab: Int
    @State var tabPositions: [CGFloat] = []
    var tabs: [String] = []
    let content: () -> Content
    
    private var tabItems: [ElegantTabItemView] = []
    var tabBarBackgroundColor: Color = .black
    var tabBarButtonsColor: Color = .white
           
    init(position: TabbarPosition,
         selectedTab: Binding<Int>,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.position = position
        self._selectedTab = selectedTab
        self.content = content
        
        ElegantTabItemView.nextTag = 0
        
        let mirror = Mirror(reflecting: content())
        self.tabItems = findTabItems(in: mirror)
        self.tabs = tabItems.map { $0.iconName }
        self._tabPositions = State(initialValue: Array(repeating: 0, count: self.tabs.count))
    }
    
    var body: some View {
        if tabItems.count > 0 {
            GeometryReader { geometry in
                ZStack {
                    if selectedTab >= 0 && selectedTab < tabItems.count {
                        tabItems[selectedTab].content
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        EmptyView()
                    }
                    
                    tabbarView(geometry: geometry)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
