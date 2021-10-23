//
//  AddNewTaskButton.swift
//  TODO App
//
//  Created by Darek on 16/10/2021.
//

import UIKit

class AddNewTaskButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        backgroundColor = .appGreen
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        layer.cornerRadius = 0.5 * self.bounds.size.width
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        titleEdgeInsets = UIEdgeInsets(top:-5, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
