//
//  TaskDetailsViewContainer.swift
//  TODO App
//
//  Created by Darek on 16/10/2021.
//

import UIKit

class TaskDetailsViewContainer: UIView {
    
    private let title: String
    private let bgColor: UIColor
    private let textField: UITextField?
    private let dataPickerView: UIDatePicker?
    private let pickerView: UIPickerView?

    init(title: String, bgColor: UIColor, textField: UITextField? = nil, dataPickerView: UIDatePicker? = nil, pickerView: UIPickerView? = nil) {
        self.title = title
        self.bgColor = bgColor
        self.textField = textField
        self.dataPickerView = dataPickerView
        self.pickerView = pickerView
        super.init(frame: UIScreen.main.bounds)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        let sectionTitle = UILabel()
        sectionTitle.text = title
        sectionTitle.font = UIFont(name: "Futura", size: 17)
        sectionTitle.textColor = .white
        addSubview(sectionTitle)
        sectionTitle.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 15, paddingLeft: 15)
        backgroundColor = bgColor.withAlphaComponent(0.3)
        layer.cornerRadius = 20
        
        if let textField = textField {
            textField.font = UIFont(name: "Futura", size: 17)
            textField.textColor = .white
            textField.textAlignment = .center
            textField.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            textField.layer.cornerRadius = 10
            
            addSubview(textField)
            textField.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 40)
        }
        
        if let dataPickerView = dataPickerView {
            dataPickerView.layer.cornerRadius = 10
            dataPickerView.locale = Locale(identifier: "pl_PL")
            dataPickerView.calendar.locale = Locale(identifier: "pl_PL")
            dataPickerView.contentVerticalAlignment = .center
            dataPickerView.contentHorizontalAlignment = .center
            dataPickerView.preferredDatePickerStyle = .compact
            dataPickerView.tintColor = .white
        
            addSubview(dataPickerView)
            dataPickerView.anchor(top: sectionTitle.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
        }
        
        if let pickerView = pickerView {
            pickerView.layer.cornerRadius = 10
            
            addSubview(pickerView)
            pickerView.anchor(top: sectionTitle.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
        }
    }
}
