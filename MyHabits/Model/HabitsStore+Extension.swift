//
//  HabitStore+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import Foundation

extension HabitsStore {
    func updateStore(with habit: Habit) {
        let notificationCenter = NotificationCenter.default

        if let habitIndex = habits.firstIndex(of: habit) {
            HabitsStore.shared.habits[habitIndex] = habit

            notificationCenter.post(name: .habitUpdated,
                                    object: self,
                                    userInfo: ["habitIndex": habitIndex,
                                               "isNew": false])
        } else {
            HabitsStore.shared.habits.append(habit)

            notificationCenter.post(name: .habitUpdated,
                                    object: self,
                                    userInfo: ["habitIndex": habits.count - 1,
                                               "isNew": true])
        }
    }

    func removeFromStore(habit: Habit) {
        HabitsStore.shared.habits.removeAll { $0 == habit }

        NotificationCenter.default.post(name: .habitRemoved,
                                        object: self)
    }

    func unTrack(from habit: Habit, date: Date) {
        habit.trackDates.removeAll { Calendar.current.isDateInToday($0) }
        save()
    }
}
