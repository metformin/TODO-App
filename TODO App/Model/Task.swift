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

protocol CategoryString  {
      var description: String { get }
}

public enum Category: Int, CaseIterable, CategoryString {
    case other
    case work
    case shopping
    
    var description: String {
        switch self {
        case .other:
            return "Inne"
        case .work:
            return "Praca"
        case .shopping:
            return "Zakupy"
        }
    }
}
