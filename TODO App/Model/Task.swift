//
//  Task.swift
//  TODO App
//
//  Created by Darek on 16/10/2021.
//

import Foundation

public struct TaskModel {
    let title: String
    let addedDate: Date
    let finishDate: Date
    let category: Category
    
    init(title: String, addedDate: Date, finishDate: Date, category: Category){
        self.title = title
        self.addedDate = addedDate
        self.finishDate = finishDate
        self.category = category
    }
}

public enum Category: String, CaseIterable {
    case other = "Inne"
    case work = "Praca"
    case shopping = "Zakupy"
}
