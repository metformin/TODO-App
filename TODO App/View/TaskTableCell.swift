//
//  TaskTableCell.swift
//  TODO App
//
//  Created by Darek on 19/10/2021.
//

import UIKit

class TaskTableCell: UITableViewCell {
    
    //MARK: - Properties
    var task: Task? {
        didSet{
            setCustomView()
        }
    }
    private let categoryContent: UIView = UIView()
    private let contentCell: UIView = {
        let contentCell = UIView()
        contentCell.backgroundColor = .appLightGrey
        contentCell.layer.cornerRadius =  20
        contentCell.clipsToBounds = true
        return contentCell
    }()
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Futura-Medium", size: 17)
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = true
        title.contentMode = .center
        title.textAlignment = .left
        title.textColor = .darkGray
        return title
    }()
    private var dateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dateImage")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()
    private var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Futura", size: 15)
        dateLabel.text = "Data"
        dateLabel.textAlignment = .left
        dateLabel.textColor = .darkGray
        return dateLabel
    }()
    private var timeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeImage")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()
    private var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name: "Futura", size: 15)
        timeLabel.text = "Time"
        timeLabel.textAlignment = .left
        timeLabel.textColor = .darkGray
        return timeLabel
    }()
    private var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        return image
    }()
    
    //MARK: - Lifecicle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(contentCell)
        contentCell.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor,
                           paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        setCategoryContent()
        setDateContennt()
        setTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Helper Functions
    func setCategoryContent(){
        contentCell.addSubview(categoryContent)
        categoryContent.anchor(top: contentCell.topAnchor, left: contentCell.leftAnchor, bottom: contentCell.bottomAnchor)
        categoryContent.widthAnchor.constraint(equalTo: contentCell.widthAnchor, multiplier: 0.2).isActive = true
        
        categoryContent.addSubview(categoryImage)
        categoryImage.centerX(inView: categoryContent)
        categoryImage.centerY(inView: categoryContent)
        categoryImage.setDimensions(height: 40, width: 40)
    }
    
    func setDateContennt(){
        contentCell.addSubview(dateImage)
        dateImage.anchor(top: contentCell.topAnchor, left: categoryContent.rightAnchor, paddingTop: 10, paddingLeft: 10)
        dateImage.setDimensions(height: 18, width: 18)
        
        contentCell.addSubview(dateLabel)
        dateLabel.anchor(left: dateImage.rightAnchor, paddingLeft: 5)
        dateLabel.centerY(inView: dateImage)
        
        contentCell.addSubview(timeImage)
        timeImage.anchor(left: dateLabel.rightAnchor, paddingLeft: 5)
        timeImage.setDimensions(height: 18, width: 18)
        timeImage.centerY(inView: dateImage)
        
        contentCell.addSubview(timeLabel)
        timeLabel.anchor(left: timeImage.rightAnchor, paddingLeft: 5)
        timeLabel.centerY(inView: dateImage)
    }
    func setTitle(){
        contentCell.addSubview(titleLabel)
        titleLabel.anchor(top: dateImage.bottomAnchor, left: categoryContent.rightAnchor, bottom: categoryContent.bottomAnchor ,right: contentCell.rightAnchor , paddingTop: 7, paddingLeft: 10, paddingBottom: 3 , paddingRight: 10)
    }
    func setCustomView(){
        titleLabel.text = task?.title
        guard let date = task?.finishDate else { return }
        dateLabel.text = dateToString(date: date)
        timeLabel.text = timeToString(date: date)
        
        switch task?.category {
        case 0:
            categoryImage.image = UIImage(named: "otherTaskImage")?.withRenderingMode(.alwaysTemplate)
            categoryContent.backgroundColor = .purple
            break
        case 1:
            categoryImage.image = UIImage(named: "workTaskImage")?.withRenderingMode(.alwaysTemplate)
            categoryContent.backgroundColor = .appGreen
            break
        case 2:
            categoryImage.image = UIImage(named: "shoppingTaskImage")?.withRenderingMode(.alwaysTemplate)
            categoryContent.backgroundColor = .brown
            break
        default:
            break
        }
    }
    
    //MARK: - Date formatters
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateFormatter.locale = Locale(identifier: "pl_PL")
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    func timeToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "pl_PL")
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
}
