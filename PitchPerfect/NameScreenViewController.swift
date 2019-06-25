//
//  NameScreenViewController.swift
//  PitchPerfect
//
//  Created by Sherif on 7/20/18.
//  Copyright © 2018 Sherif-Eldeeb. All rights reserved.
//

import UIKit

class NameScreenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Name.text = String()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "FileName", sender: Name)
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FileName" {
            let RecordVC = segue.destination as! recordSoundsViewController
            RecordVC.file_Name = Name.text!
        }
    }
    
}
