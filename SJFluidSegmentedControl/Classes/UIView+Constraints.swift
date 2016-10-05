//
//  UIView+Constraints.swift
//  SJFluidSegmentedControl
//
//  Created by Sasho Jadrovski on 9/22/16.
//  Copyright © 2016 Sasho Jadrovski. All rights reserved. [http://jadrovski.com]
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

extension UIView {
    
    /// Removes specified set of constraints from the views in the receiver's subtree and from the receiver itself.
    ///
    /// - parameter constraints: A set of constraints that need to be removed.
    func removeConstraintsFromSubtree(_ constraints: Set<NSLayoutConstraint>) {
        var constraintsToRemove = [NSLayoutConstraint]()
        
        for constraint in self.constraints {
            if constraints.contains(constraint) {
                constraintsToRemove.append(constraint)
            }
        }
        
        self.removeConstraints(constraintsToRemove)
        
        for view in self.subviews {
            view.removeConstraintsFromSubtree(constraints)
        }
    }
    
}
