//
//  NotoficationName+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import Foundation

extension Notification.Name {
    static var habitUpdated: Notification.Name {
        .init(rawValue: "Habit.updated")
    }

    static var habitRemoved: Notification.Name {
        .init(rawValue: "Habit.removed")
    }
}
