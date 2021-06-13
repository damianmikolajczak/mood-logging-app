//
//  MoodLogViewController.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 26/05/2021.
//

import UIKit

class MoodsSetViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var moods = Array<Mood>()
    
    @IBOutlet weak var moodLogsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodLogsTable.dataSource = self
        moodLogsTable.delegate = self
        
        fetachData()
        moodLogsTable.rowHeight = 150
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetachData()
    }
    
    func fetachData() {
        do {
            moods = try context.fetch(Mood.fetchRequest())
        } catch  { }
        
        moodLogsTable.reloadData()
    }
}

extension MoodsSetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoodCell", for: indexPath) as! MoodTableViewCell
        let index = moods.count - indexPath.row - 1 //The logs should be displayed from the newset to oldest one.
        var peopleText = String()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .full
        
        if let people = moods[index].people, people.count > 0 {
            for person in people {
                peopleText.append(person + ", ")
            }
        } else {
            peopleText = "No one was with you."
        }
        
        cell.logDateText.text = formatter.string(from: moods[index].date!)
        cell.logFeelingText.text = "\(moods[index].feeling)"
        cell.logFeelingImage.image = UIImage(named: "\(moods[index].feeling)")
        cell.logActivityText.text = "\(moods[index].activity)"
        cell.logActivityImage.image = UIImage(named: "\(moods[index].activity)")
        cell.logPeopleText.text = peopleText

        return cell
    }
}

extension MoodsSetViewController: UITableViewDelegate {
    
}
