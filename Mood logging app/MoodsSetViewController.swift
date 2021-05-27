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
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        cell.logDateText.text = formatter.string(from: moods[indexPath.row].date!)
        cell.logFeelingText.text = "\(moods[indexPath.row].feeling)"
        cell.logActivityText.text = "\(moods[indexPath.row].activity)"
        
        var peopleText = String()
        
        if let people = moods[indexPath.row].people, people.count > 0 {
            for person in people {
                peopleText.append(person + " ")
            }
        } else {
            peopleText = "No one was with you."
        }
        
        cell.logPeopleText.text = peopleText

        return cell
    }
}

extension MoodsSetViewController: UITableViewDelegate {
    
}
