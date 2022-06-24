//
//  CategoryViewController.swift
//  IntegradorIOS
//
//  Created by Gustavo Antunes Malheiros on 23/06/22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let categoryService = CategoryService()
    var delegate: DataDelegate?
    
    var activityType:String = ""
    var participants:Int = 0
    var random:Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var numberParticipantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tryAnotherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(category: activityType, participants: participants, random: random)
    }
    
    
    @IBAction func tryAnother(_ sender: UIButton) {
        fetchData(category: activityType, participants: participants, random: random)
    }
    
    func messageError() {
        let alert = UIAlertController(title: "ERROR", message: "There is no data here...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func fetchData(category:String, participants:Int, random: Bool){
        print("Category from fetchData: " + category)
        print(participants)
        categoryService.getCategories(category: category, participants: participants, random: random ) {
            dataResponse in
            switch dataResponse {
            case .success(let success):
                DispatchQueue.main.async {
                    self.titleLabel.text = random ? "Random" : success.type.capitalized
                self.informationLabel.text = success.activity
                self.numberParticipantsLabel.text = String(success.participants)
                self.priceLabel.text = self.priceFormater(value: success.price)
                    self.typeLabel.text = random ? success.type.capitalized : ""
                self.reloadInputViews()
                }
            case .failure(let error):
                print(error)
                self.messageError()
            }
        }
    }
    
    func priceFormater(value:Double) -> String{
        switch value {
        case let x where x > 0 && x <= 0.3:
            return "Low"
        case let x where x > 0.3 && x <= 0.6:
            return "Medium"
        case let x where x > 0.6:
            return "High"
        default:
            return "Free"
        }
    }
    
}
