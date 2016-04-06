//
//  Extensions.swift
//  HarmonyHelper
//
//  Created by Ale Fernandes Antunes on 3/22/16.
//  Copyright © 2016 Ale Fernandes Antunes. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var maxX: CGFloat {
        get {
            return CGRectGetMaxX(self.frame)
        }
    }
    
    var minX: CGFloat {
        get {
            return CGRectGetMinX(self.frame)
        }
    }
    
    var minY: CGFloat {
        get {
            return CGRectGetMinY(self.frame)
        }
    }
    
    var maxY: CGFloat {
        get {
            return CGRectGetMaxY(self.frame)
        }
    }
    var width: CGFloat {
        get {
            return self.frame.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.height
        }
    }
    
    func changeOrigin(x:CGFloat, y:CGFloat) {
        self.frame = CGRectMake(x,y, self.bounds.width, self.bounds.height)
    }
    
    func changeSize(width:CGFloat, height:CGFloat) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height)
    }
    
    func stackMeBelowThisXCentered(relativeElement:UIView, view: UIView, air:CGFloat) {
        let nextStackedYPos:CGFloat = relativeElement.frame.origin.y + relativeElement.bounds.height + air
        
        self.frame = CGRectMake(
            (view.width / 2) - (self.bounds.width / 2),
            nextStackedYPos,
            self.bounds.width,
            self.bounds.height)
    }
    
    func stackMeBelowThisXCenteredAndChangeSize(relativeElement:UIView, air:CGFloat, width:CGFloat, height:CGFloat) {
        let nextStackedYPos:CGFloat = relativeElement.frame.origin.y + relativeElement.bounds.height + air
        
        self.frame = CGRectMake(
            (self.frame.width / 2) - (self.bounds.width / 2),
            nextStackedYPos,
            width,
            height)
    }
    
}
