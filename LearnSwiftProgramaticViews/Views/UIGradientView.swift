//
//  UIGradientView.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/19/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

/**
 This subclass of UIView provides a way of producing a gradient on the view
 that is updated by the view during the layout of the subviews. You create the gradient
 by calling addLinearGradient(_:, _:, _:) on the view
 */
class UIGradientView: UIView {
    
    var gradientLayer: CAGradientLayer?
    
    enum GradientOrientation{case descending, ascending, leading, trailing}
    
    /**
     Add the gradient color to the view with four directional options to choose from.
     - Parameters:
        - colors: An Array of colors to make up the gradient
        - orientation: The direction of the gradient
        - position: The postion of the gradient layer in the layer heirarchy
     - Returns: Void
     */
    func addLinearGradient(colors: [UIColor], _ orientation: GradientOrientation? = nil, position: UInt32? = nil) {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = colors.map{$0.cgColor}
        gradientLayer?.frame = bounds
        
        if let orientationSpecified = orientation {
            switch orientationSpecified{
            case .ascending:
                gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
            case .descending: break
            case .leading:
                gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
            case .trailing:
                gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
            }
        }
        
        guard let gLayer = gradientLayer else {return}
        if let positionSpecified = position{layer.insertSublayer(gLayer, at: positionSpecified)}
        else{layer.addSublayer(gLayer)}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
}
