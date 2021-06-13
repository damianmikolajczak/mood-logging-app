//
//  WakingHoursSetupViewController.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 26/05/2021.
//

import UIKit

class WakingHoursSetupViewController: UIViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func SaveWakingHours() {
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        if (endDate.timeIntervalSince(startDate) < 0) {
            
            alert.title = "Check waking hours"
            alert.message = "The start time is later than the end time."
            
        } else {
            let lnm = LocalNotificationManager()
            lnm.RemoveAllPendingNotification()
            lnm.AddLocalNotification(startDate: startDate, endDate: endDate)
            
            alert.title = "Waking where updated"
            alert.message = "Your waking hours where successfull updated."
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
