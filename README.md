# Mood logger
## Introduction
This is an app to log users mood within the given waking hours. The user can specify when he wants to receive local notifications which reminds him to log mood. A mood log consists of how the user feel, what activity is he doing and who is he currently with. The given moods are displayed then in a table.

## Technologies
The whole app was written in Swift using the UIKit framework and Xcode. The user interface was made in storyboard with some additional features implemented in the view controller code (like the transistions between view controllers or swaping the images for feelings and activities). 
To store the given moods there was a CoreData model created. The CoreData model was exteanded with some counted properties that mediate between the definied enums and the stored values.

## Screenshots
The main screen of the app will apear after you tap a recieved notification or simply just by entering the app - the time you recieve a notification depends on your waking hours.
On the main screen the user can log new moods by choosing one og the given feelings - new feelings can by simply added in the Models/Mood+CoreDataClass.Swift file as an FeelingTag enum.
The user can also specify the current activity which is also an enum type and can by simpy extended as described above. Each feeling and activity has its own individual image.
The last thing the users can store in their mood log is a table of people that are with them.

<img src="Mood%20logging%20app/Images/logMood.PNG" width="250"> <img src="Mood%20logging%20app/Images/logMood_2.PNG" width="250"> <img src="Mood%20logging%20app/Images/logMood_3.PNG" width="250">

By taping the "+Add" label in the above showed view the user can add new people to the table - a new popup view will apear.
The user can then write down the name and save it or go back to the mood loggin view.

<img src="Mood%20logging%20app/Images/addPerson.PNG" width="250">

All of the logged moods can by presented to the user in a table view just by tapping the "Mood logs" on the bottom tab bar.
As said, the logs ar showed as a table view with all the necessary informations - the log date and the mood itself.
In addition there could be added a graph that presents some correlations betwen the activity or the environment and the users mood.

<img src="Mood%20logging%20app/Images/moodLogs.PNG" width="250">

The waking hours can by specified by tapping the "Waking hours" item in the bottom tab bar.
The user can put in the time when he start and ends his waking hours.
The LocalNotificationManager calculates then the time interval betwen the given hours so that the user will recieve exactly 5 local notifications in a constant period of time during the waking hours.
When the new hours where saved, a simply alert window will give a basic feedback to the user.

<img src="Mood%20logging%20app/Images/wakingHours.PNG" width="250"> <img src="Mood%20logging%20app/Images/updatedHours.PNG" width="250">

## Calculating the notifications time itnerval

```swift
/*
* This is a function defined in the LocalNotificationManager class.
* This function is used to create local notifications for 5 times (in a constant time interval) in the given waking hours.
*/
func AddLocalNotification(startDate: Date, endDate: Date) {
        
        //First we need to get the current notification center and check the permissions
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {granted, error in})
        
        //Then we create a new notification content with a specified title, body and sound.
        let content = UNMutableNotificationContent()
        content.title = "Time to log your mood"
        content.body = "Please go into the app and log your mood"
        content.sound = .default
        
        /*
        * Based on the given waking hours there is calculated a time perdiod for the five notification.
        * Simply deviding by five the time between tha start and end time.
        * The solution is given in seconds!
        */
        let notificationInterval = endDate.timeIntervalSince(startDate) / 5
        
        //The last thing is to create a repeating trigger for each of the five notifications
        for k in 1...5 {
            
            /*
            * There is a triger date which equals the waking hours start time and additional time interval.
            * The additional time interval equals the calculated time period times the loop parameter.
            * From the trigger date we only need the hour and minut component.
            */
            let triggerDate = startDate.addingTimeInterval(Double(k)*notificationInterval)
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: triggerDate)
            
            /*
            * Based on the date components there is a callendar notification trigger created.
            * The trigger is used to create a request which is then added to the current notification center
            * Each notification gets a ID based on number in the notifications queue at the day.
            */
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "\(k) notification", content: content, trigger: trigger)
         
            center.add(request, withCompletionHandler: nil)
        }
    }
```

