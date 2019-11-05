//
//  DBScrollerView.swift
//  app
//
//  Created by harry on 2019/11/5.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit

class DBScrollView: UIScrollView {

    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        if  event?.allTouches?.count == 1 {
            return true
        }
        return false
    }

}
