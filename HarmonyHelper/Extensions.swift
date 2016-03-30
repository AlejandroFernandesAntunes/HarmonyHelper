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
    func changeOrigin(x:CGFloat, y:CGFloat) {
        self.frame = CGRectMake(x,y, self.bounds.width, self.bounds.height)
    }
}
