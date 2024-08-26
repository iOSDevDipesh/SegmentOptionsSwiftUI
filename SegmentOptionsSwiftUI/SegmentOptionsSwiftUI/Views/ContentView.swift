//
//  ContentView.swift
//  SegmentOptionsSwiftUI
//
//  Created by Dipesh Makvana on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSegmentIndex = 0
    let segmentTitles = ["$", "USD"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Selected Index: \(selectedSegmentIndex)")
                Spacer() // Pushes the segmented control to the trailing side
                CustomSegmentedControlView(selectedIndex: $selectedSegmentIndex, titles: segmentTitles)
                    .paddingHorizontal(12)
                    .segmentPadding(4)
                    .backgroundColor(Color(hex: "EEEEEE"))
                    .selectionColor(Color(hex: "5546FF"))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 3)
                    .animationDuration(0.25)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
