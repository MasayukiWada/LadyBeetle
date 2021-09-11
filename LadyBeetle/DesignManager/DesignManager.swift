//
//  DesignManager.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit

class DesignManager: NSObject {
    
    // MARK: - buttons
    static func themeColorButton(button:UIButton, textSize:CGFloat){
        button.backgroundColor = DesignManager.themeColor()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: textSize)
        button.layer.cornerRadius = 4.0
    }
    
    
    // MARK: - colors
    
    class func themeColor()->UIColor{
        
        let color = UIColor.init(red: 0.8, green: 0.3, blue: 0.5, alpha: 1.0)
        return color
    }
    
    
    // MARK: - lifecycle
    
    static let shared = DesignManager()
    
    private override init() {
        super.init()
    }

}
