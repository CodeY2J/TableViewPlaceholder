//
//  TableViewPlaceholder.swift
//  TableViewPlaceholder
//
//  Created by Limingkai on 16/12/15.
//  Copyright © 2016年 ctbri. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

fileprivate class ClosureWrapper {
    var closure: (() -> UIView)?
    
    init(_ closure: (() -> UIView)?) {
        self.closure = closure
    }
}

extension UITableView {

    private struct AssociatedKeys {
        static var DescriptiveName = "lmk_DescriptiveName"
    }
    
   open var placeholder: (() -> UIView)? {
        get {
            if let cl = objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? ClosureWrapper {
                return cl.closure
            }
            return nil
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self,&AssociatedKeys.DescriptiveName,ClosureWrapper(newValue),.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    public func lmk_reloadData() {
        reloadData()
        checkEmpty()

    }
    
    fileprivate func checkEmpty() {
        var isEmpty = true
        var sections = 0
        
        if dataSource!.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
            if let section = dataSource?.numberOfSections!(in: self) {
                sections = section - 1
            }
        }

        for index in 0...sections {
            if (dataSource?.tableView(self, numberOfRowsInSection: index))! > 1 {
                isEmpty = false
                break
            }
        }
        
        if isEmpty && (self.placeholder != nil) {
            let view = viewWithTag(10001)
            view?.removeFromSuperview()
            let placeholder = self.placeholder!()
            placeholder.frame = bounds
            placeholder.tag = 10001
            self.addSubview(self.placeholder!())
        } else {
            self.placeholder!().removeFromSuperview()
            self.placeholder = nil
        }
        
    }

}
