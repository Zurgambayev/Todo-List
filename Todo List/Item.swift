//
//  Item.swift
//  Todo List
//
//  Created by Зейнаддин Зургамбаев on 15.02.2024.
//

import Foundation

struct Item: Identifiable,Codable {
    var id = UUID()
    var todo: String // Добавлено свойство для хранения задачи
}
