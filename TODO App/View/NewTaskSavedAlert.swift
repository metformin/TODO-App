//
//  NewTaskSavedAlert.swift
//  TODO App
//
//  Created by Darek on 18/10/2021.
//

import UIKit

class NewTaskSavedAlert: UIView {
    
    private let confirmationText: UILabel = {
       let label = UILabel()
        label.text = "Dodano nowe zadanie"
        label.font = UIFont(name: "Futura", size: 13)
        label.textColor = .white
        return label
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        
        addSubview(confirmationText)
        confirmationText.centerY(inView: self)
        confirmationText.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
