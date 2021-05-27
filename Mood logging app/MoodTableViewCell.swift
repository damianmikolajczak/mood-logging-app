//
//  MoodTableViewCell.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 27/05/2021.
//

import UIKit

class MoodTableViewCell: UITableViewCell {
    @IBOutlet weak var logDateText: UILabel!
    @IBOutlet weak var logFeelingText: UILabel!
    @IBOutlet weak var logFeelingImage: UIImageView!
    @IBOutlet weak var logActivityText: UILabel!
    @IBOutlet weak var logActivityImage: UIImageView!
    @IBOutlet weak var logPeopleText: UILabel!
}
