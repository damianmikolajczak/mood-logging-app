//
//  AddPersonViewController.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 27/05/2021.
//

import UIKit

class AddPersonViewController: UIViewController {

    public var completitionHandler:((String)->Void)?
    
    @IBOutlet weak var personName: UITextField!
    
    @IBAction func addPerson () {
        if let name = personName.text, name != "" {
            completitionHandler?(name)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
