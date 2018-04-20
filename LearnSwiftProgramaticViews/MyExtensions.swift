//
//  MyExtensions.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/19/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

extension UIColor{
    
    ///An initializer for using hex values in the form of 255, 255, 255, 255 as found in Sketch App
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat? = nil) {
        self.init(
            red: (r > 255 ? 1 : (r < 0 ? 0 : r/255)),
            green: (g > 255 ? 1 : (g < 0 ? 0 : g/255)),
            blue: (b > 255 ? 1 : (b < 0 ? 0 : b/255)),
            alpha: alpha ?? 1)
    }
    
    static var lSSDBlue: UIColor{return UIColor(r: 44, g: 106, b: 156)}
    static var lSSDTeal: UIColor{return UIColor(r: 28, g: 185, b: 141)}
    static var lSSDYellow: UIColor{return UIColor(r: 251, g: 175, b: 64)}
    static var lSSDOrange: UIColor{return UIColor(r: 255, g: 53, b: 39)}
    
}

extension UIView{
    ///Snaps a view precisely to the dimesions and position of a UILayoutGuide
    func snapToGuide(_ layoutGuide: UILayoutGuide) {
        [self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
         self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
         self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
         self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
            ].forEach{$0.isActive = true}
    }
}
