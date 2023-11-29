//
//  CALayer+Border.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

public extension CALayer {
    
    func addBorder(color: UIColor = .black, width: CGFloat = 1) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
    
    /// **Must called after frame set. ex) layoutSubviews, viewDidAppear, ...**
    func addBorder(_ edges: [UIRectEdge], color: UIColor = .black, width: CGFloat = 1) {
        edges.forEach { edge in
            let border = CALayer()
            
            switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
