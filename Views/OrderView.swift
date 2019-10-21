//
//  OrderView.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI

struct OrderView: View {
    let order : [Card]
    var views = [AnyView]()
    let foobar = ["Hello", "Goodbye"]
    var uglyThings = [AnyView]()
    
    
    init(_ orderIn: [Card]) {
        order = orderIn
        print("Real contents: \(order)")
    }
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        ZStack {
            ForEach(0..<self.order.count, id:\.self) { index in
                Circle()
                    .frame(width: 100, height: 100, alignment: .center)
                    .position(x: CGFloat(100 + 100 * index), y: 100)
                    .foregroundColor(self.order[index].color)
            }
        }
        .frame(width: 400, height: 400, alignment: .leading)
        .position(x: 400, y: 1000)
    }
}
