//
//  CustomSegmentedControlView.swift
//  SegmentOptionsSwiftUI
//
//  Created by Dipesh Makvana on 26/08/24.
//

import SwiftUI

struct CustomSegmentedControlView: View {
    @Binding var selectedIndex: Int
    var titles: [String]
    var segmentHeight: CGFloat = 31.0
    
    @State private var maxSegmentWidth: CGFloat = 0
    
    // Customizable properties with default values
    var paddingHorizontal: CGFloat = 16
    var segmentPadding: CGFloat = 3
    var segmentBackgroundColor: Color = Color(.systemGray5)
    var selectionIndicatorColor: Color = .blue
    var cornerRadius: CGFloat = .greatestFiniteMagnitude
    var shadowColor: Color = Color.black.opacity(0.1)
    var shadowRadius: CGFloat = 3
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 2
    var animationDuration: Double = 0.3

    // Chainable methods to configure the view

    public func paddingHorizontal(_ value: CGFloat) -> Self {
        var copy = self
        copy.paddingHorizontal = value
        return copy
    }
    
    public func segmentPadding(_ value: CGFloat) -> Self {
        var copy = self
        copy.segmentPadding = value
        return copy
    }
    
    public func backgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.segmentBackgroundColor = color
        return copy
    }
    
    public func selectionColor(_ color: Color) -> Self {
        var copy = self
        copy.selectionIndicatorColor = color
        return copy
    }
    
    public func cornerRadius(_ radius: CGFloat) -> Self {
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
    
    public func shadow(color: Color, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) -> Self {
        var copy = self
        copy.shadowColor = color
        copy.shadowRadius = radius
        copy.shadowX = x
        copy.shadowY = y
        return copy
    }
    
    public func animationDuration(_ duration: Double) -> Self {
        var copy = self
        copy.animationDuration = duration
        return copy
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                // Measure the width of the widest segment
                HStack(spacing: 0) {
                    ForEach(titles, id: \.self) { title in
                        Text(title)
                            .padding(.horizontal, paddingHorizontal)
                            .background(GeometryReader { geometry in
                                Color.clear.onAppear {
                                    let width = geometry.size.width
                                    if width > maxSegmentWidth {
                                        maxSegmentWidth = width
                                    }
                                }
                            })
                    }
                }
                .opacity(0) // Hide the measuring view
                .frame(height: 0)
                
                ZStack(alignment: .leading) {
                    // Background for all segments
                    RoundedRectangle(cornerRadius: segmentHeight / 2)
                        .fill(segmentBackgroundColor)
                        .frame(width: totalWidth(), height: segmentHeight)
                    
                    // Selection indicator
                    RoundedRectangle(cornerRadius: segmentHeight / 2)
                        .fill(selectionIndicatorColor)
                        .frame(width: maxSegmentWidth, height: segmentHeight)
                        .offset(x: CGFloat(selectedIndex) * maxSegmentWidth)
                        .animation(.easeInOut(duration: animationDuration), value: selectedIndex)
                    
                    HStack(spacing: 0) {
                        ForEach(0..<titles.count, id: \.self) { index in
                            Text(titles[index])
                                .foregroundColor(selectedIndex == index ? .white : .primary)
                                .frame(width: maxSegmentWidth, height: segmentHeight)
                                .onTapGesture {
                                    withAnimation {
                                        selectedIndex = index
                                    }
                                }
                        }
                    }
                }
                .padding(segmentPadding)
                .background(segmentBackgroundColor)
                .cornerRadius(cornerRadius)
            }
        }
    }
    
    // Calculate the total width based on the widest segment
    private func totalWidth() -> CGFloat {
        return maxSegmentWidth * CGFloat(titles.count)
    }
}

#Preview {
    CustomSegmentedControlView(selectedIndex: .constant(1), titles: ["1", "2", "3"])
}
