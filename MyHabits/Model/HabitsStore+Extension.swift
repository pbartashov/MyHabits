//
//  HabitStore+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import Foundation

protocol HabitsStoreDelegate: AnyObject {
    func updateHabit(_ habit: Habit)
    func removeHabit(_ habit: Habit)
}
