//
//  AspectVGrid.swift
//  Remember
//
//  Created by Redwan Khan on 12/17/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View //where Item: Identifiable (another way of writing the syntax
// these items and their types are dont cares. it doesnt matter what the object is, all that matters is the type like Identifiable and View
{
    var items:[Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader {geometry in //made it so that
            let gridItemSize = griditemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
//    func griditemWidthThatFits(count: Int,
//                               size: CGSize,
//                               atAspectRatio aspectRatio: CGFloat
//    ) -> CGFloat {
//        let count = CGFloat(count)
//        var columnCount = 1.0
//        
//        repeat {
//            
//            let width = size.width / columnCount
//            let height = width / aspectRatio
//            
//            let rowCount = (count / columnCount).rounded(.up)
//            if rowCount * height < size.height {
//                return (size.width / columnCount).rounded(.down)
//            }
//            columnCount += 1
//            
//        } while columnCount < count
//        return min(size.width / count, size.height * aspectRatio).rounded(.down)
//        //return 85
//    }
    
    func griditemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        // Calculate number of columns and rows based on the screen size and aspect ratio
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, count)
        var minDiff: CGFloat = .greatestFiniteMagnitude

        for columns in 1...count {
            let rows = (count + (columns - 1)) / columns
            let itemWidth = size.width / CGFloat(columns)
            let itemHeight = itemWidth / aspectRatio
            let totalHeight = CGFloat(rows) * itemHeight
            let diff = abs(size.height - totalHeight)

            if diff < minDiff {
                minDiff = diff
                bestLayout = (rows, columns)
            }
        }

        return size.width / CGFloat(bestLayout.columnCount)
    }

}

//#Preview {
//    AspectVGrid(items: items, content: content)
//}
