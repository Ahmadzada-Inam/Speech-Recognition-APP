//
//  CircleButton.swift
//  Scribe
//
//  Created by Inam Ahmad-zada on 2016-11-30.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet{
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = cornerRadius
    }

}
