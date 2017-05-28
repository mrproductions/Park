//
//  RoundTextField.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 30.11.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit

@IBDesignable

class RoundTextField: UITextField{

    // MARK: NextResponder 
    
    @IBOutlet open weak var nextResponderField: UIResponder?
    
    /**
     Creates a new view with the passed coder.
     
     :param: aDecoder The a decoder
     
     :returns: the created new view.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    /**
     Creates a new view with the passed frame.
     
     :param: frame The frame
     
     :returns: the created new view.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    /**
     Sets up the view.
     */
     func setUp() {
        addTarget(self, action: #selector(actionKeyboardButtonTapped(sender:)), for: .editingDidEndOnExit)
    }
    
    /**
     Action keyboard button tapped.
     
     :param: sender The sender of the action parameter.
     */
    @objc private func actionKeyboardButtonTapped(sender: UITextField) {
        switch nextResponderField {
        case let button as UIButton where button.isEnabled:
            button.sendActions(for: .touchUpInside)
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
    
// MARK: Design
    
    
    
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
    @IBInspectable var placeholderColor: UIColor?{
        didSet{
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSForegroundColorAttributeName: placeholderColor!])
            attributedPlaceholder = str
            
        }
    }
    
    
    
}
