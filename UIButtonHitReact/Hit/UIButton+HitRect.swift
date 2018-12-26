//
//  UIButton+HitRect.swift
//  SaintPartner
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import UIKit

private var topNameKey = "topNameKey"
private var rightNameKey = "rightNameKey"
private var bottomNameKey = "bottomNameKey"
private var leftNameKey = "leftNameKey"

extension UIButton {
    
    public func setEnlargeEdgeWithTop(top:CGFloat,right:CGFloat,bottom:CGFloat,left:CGFloat){
        
        objc_setAssociatedObject(self, &topNameKey, NSNumber(value: Float(top)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &rightNameKey, NSNumber(value: Float(right)), .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &bottomNameKey, NSNumber(value: Float(bottom)), .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &leftNameKey, NSNumber(value: Float(left)), .OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    func enlargedRect() -> CGRect{
        guard var topEdge = objc_getAssociatedObject(self, &topNameKey), var rightEdge = objc_getAssociatedObject(self, &rightNameKey),var bottomEdge = objc_getAssociatedObject(self, &bottomNameKey),var leftEdge = objc_getAssociatedObject(self, &leftNameKey)else {
            return self.bounds
        }
        topEdge = topEdge as! NSNumber
        rightEdge = rightEdge as! NSNumber
        bottomEdge = bottomEdge as! NSNumber
        leftEdge = leftEdge as! NSNumber
        
        if ((topEdge as AnyObject).boolValue  && (rightEdge as AnyObject).boolValue  && (bottomEdge as AnyObject).boolValue  && (leftEdge as AnyObject).boolValue)
        {
            return CGRect.init(x: self.bounds.origin.x - CGFloat((leftEdge as AnyObject).floatValue), y: self.bounds.origin.y - CGFloat((topEdge as AnyObject).floatValue), width: self.bounds.size.width + CGFloat((leftEdge as AnyObject).floatValue) + CGFloat((rightEdge as AnyObject).floatValue), height: self.bounds.size.height + CGFloat((topEdge as AnyObject).floatValue) + CGFloat((bottomEdge as AnyObject).floatValue));
        }else
        {
            return self.bounds
        }
    }
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRect : CGRect  = self.enlargedRect()
        if (buttonRect.equalTo(self.bounds)) {
            return super.point(inside: point, with: event)
        }
        return buttonRect.contains(point) ? true : false;
    }
}
