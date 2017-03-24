//
//  RoundButton.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 01.12.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit

@IBDesignable

class RoundButton: UIButton{
 
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidht: CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWidht
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
        
    }
    @IBInspectable var bgColor: UIColor?{
        didSet {
            backgroundColor = bgColor
        }
        
    }
    
}
