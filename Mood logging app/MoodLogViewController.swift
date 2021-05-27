//
//  MoodsSetViewController.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 26/05/2021.
//

import UIKit

class MoodLogViewController: UIViewController {
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var feelings = Array<String>()
    var activities = Array<String>()
    var feeling = Mood.FeelingTag(rawValue: 0)
    var activity = Mood.ActivityTag(rawValue: 0)
    var persons = Array<String>()
    var moods = Array<Mood>()

    @IBOutlet weak var feelingPicker: UIPickerView!
    @IBOutlet weak var moodFaceView: UIImageView!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var personTableView: UITableView!

    @IBAction func addPerson() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
        vc.completitionHandler = { name in
            let person = name
            self.persons.append(person)
            self.personTableView.reloadData()
        }
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }

    @IBAction func saveMood() {
        let newMood = Mood(context: context)
        newMood.date = Date()
        newMood.people = persons
        newMood.feeling = feeling!
        newMood.activity = activity!
        
        do { try context.save() } catch  { }
    }

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
        
        do {
            self.moods = try context.fetch(Mood.fetchRequest())
        } catch { }
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
}

extension MoodLogViewController: UIPickerViewDataSource {
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

extension MoodLogViewController: UIPickerViewDelegate {
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
            feeling = Mood.FeelingTag.init(rawValue: Int16(row))
        case activityPicker:
            activityImage.image = UIImage(named: activities[row])
            activity = Mood.ActivityTag.init(rawValue: Int16(row))
        default:
            return
        }
    }
}

extension MoodLogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row]
        return cell
    }
}

extension MoodLogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
