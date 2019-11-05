//
//  DBPaintPath.swift
//  app
//
//  Created by harry on 2019/11/5.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit

class DBPaintPath: UIBezierPath {
    init(width:CGFloat,startPoint:CGPoint) {
        super.init()
        self.lineWidth = width
        self.lineCapStyle = .round; //线条拐角
        self.lineJoinStyle = .round; //终点处理
        self.move(to: startPoint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
