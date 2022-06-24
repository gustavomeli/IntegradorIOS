//
//  ViewController.swift
//  IntegradorIOS
//
//  Created by Gustavo Antunes Malheiros on 20/06/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, DataDelegate {

    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var termsConditionsButton: UIButton!
    
    var valueOfParticipants = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = true
        
    }
    
    @objc func passingDataToActivitiesViewController(){
        let activitiesViewControler = ActivitiesViewController()
        activitiesViewControler.delegate = self
        activitiesViewControler.participants = Int(participantsTextField.text ?? "") ?? 0
        navigationController?.pushViewController(activitiesViewControler, animated: true)
    }
    

     @IBAction func startAction(_ sender: UIButton) {
        perform(#selector(passingDataToActivitiesViewController), with: nil)
    }
    
    @IBAction func termsAndConditionsAction(_ sender: UIButton){
        let navDetailViewController = UINavigationController(rootViewController: DetailViewController())
        navDetailViewController.modalPresentationStyle = .fullScreen
        self.present(navDetailViewController, animated: false, completion: nil)
    }
    
    @IBAction func textFieldEditingAction(_ sender: Any) {
        guard let text = participantsTextField.text else {
            return
        }
        
        let numbers = CharacterSet(charactersIn: text)
        
        if CharacterSet.decimalDigits.isSuperset(of: numbers){
            startButton.isEnabled = true
            startButton.alpha = 1.0
        } else {
            startButton.isEnabled = false
            startButton.alpha = 0.5
        }
    }
    
}

