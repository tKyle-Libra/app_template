//
//  User.swift
//  app
//
//  Created by harry on 2019/10/18.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import AuroraIMUI
import JKCategories

class User: NSObject, IMUIUserProtocol {
  
    let defaultImage =  UIImage.jk_image(with: .red)
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func userId() -> String {
        return ""
    }
    
    func displayName() -> String {
        return ""
    }
    
    func Avatar() -> UIImage? {
        return defaultImage
    }
}
