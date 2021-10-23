//
//  TableViewExtensions.swift
//  TODO App
//
//  Created by Darek on 21/10/2021.
//

import UIKit

extension UITableView {
    func setNoDataPlaceholder(title: String, subtitle: String) {
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont(name: "Futura-Medium", size: 30)
            titleLabel.textColor = .darkGray
            titleLabel.contentMode = .bottom
            titleLabel.textAlignment = .center
            titleLabel.sizeToFit()
            titleLabel.text = title
            return titleLabel
        }()
        
        let subtitleLabel: UILabel = {
            let subtitleLabel = UILabel()
            subtitleLabel.font = UIFont(name: "Futura", size: 15)
            subtitleLabel.textColor = .lightGray
            subtitleLabel.contentMode = .top
            subtitleLabel.textAlignment = .center
            subtitleLabel.sizeToFit()
            subtitleLabel.text = "Tutaj pojawią się zadania gdy zostaną dodane"
            return subtitleLabel
        }()
        
        let contentView = UIView()
        
        self.backgroundView?.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        
        contentView.addSubview(titleLabel)
        titleLabel.centerY(inView: contentView)
        titleLabel.centerX(inView: contentView)
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingLeft: 10, paddingRight: 10)

        self.isScrollEnabled = false
        self.backgroundView = contentView
    }
    
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
    }
}
