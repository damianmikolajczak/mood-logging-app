//
//  MoodsSetViewController.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 26/05/2021.
//

import UIKit

class MoodsSetViewController: UIViewController {

    var feelings = Array<String>()
    var activities = Array<String>()
    var persons = Array<String>()
    
    @IBOutlet weak var feelingPicker: UIPickerView!
    @IBOutlet weak var moodFaceView: UIImageView!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var personTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feelingPicker.dataSource = self
        feelingPicker.delegate = self
        activityPicker.dataSource = self
        activityPicker.delegate = self
        personTableView.dataSource = self
        personTableView.delegate = self
        
        getFeelingPickerData()
        getActivityPickerData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personTableView.reloadData()
    }
    
    func getFeelingPickerData() {
        for feeling in Mood.FeelingTag.allCases {
            feelings.append("\(feeling)")
        }
    }
    
    func getActivityPickerData() {
        for activity in Mood.ActivityTag.allCases {
            activities.append("\(activity)")
        }
    }

    @IBAction func addPerson() {
        
    }

}

extension MoodsSetViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case feelingPicker:
            return feelings.count
        case activityPicker:
            return activities.count
        default:
            return 0
        }
    }
    
    
}

extension MoodsSetViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case feelingPicker:
            return feelings[row]
        case activityPicker:
            return activities[row]
        default:
            return "N/A"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case feelingPicker:
            moodFaceView.image = UIImage(named: feelings[row])
        case activityPicker:
            activityImage.image = UIImage(named: activities[row])
        default:
            return
        }
    }
}

extension MoodsSetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row]
        return cell
    }
    
    
}
extension MoodsSetViewController: UITableViewDelegate {
    
}
