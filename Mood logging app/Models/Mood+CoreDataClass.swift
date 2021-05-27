//
//  Mood+CoreDataClass.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 26/05/2021.
//
//

import Foundation
import CoreData

@objc(Mood)
public class Mood: NSManagedObject {
    enum FeelingTag: Int16, CaseIterable {
        case Good = 0
        case OK = 1
        case Bad = 2
    }
    
    enum ActivityTag: Int16, CaseIterable {
        case Work = 0
        case Leisure = 1
        case Excercise = 2
    }
    
    var feeling: FeelingTag {
        get {
            return FeelingTag(rawValue: feelingValue)!
        }
        set {
            self.feelingValue = newValue.rawValue
        }
    }
    
    var activity: ActivityTag {
        get {
            return ActivityTag(rawValue: activityValue)!
        }
        set {
            self.activityValue = newValue.rawValue
        }
    }
}
