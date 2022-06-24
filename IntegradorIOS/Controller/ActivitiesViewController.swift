//
//  ActivitiesViewController.swift
//  IntegradorIOS
//
//  Created by Gustavo Antunes Malheiros on 23/06/22.
//

import UIKit
import Foundation

class ActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataDelegate{
    
    @IBOutlet weak var activitiesTableView: UITableView!
    @IBOutlet var shuffleButton: UIButton!
    
    var delegate: DataDelegate?
//    var activityType:String = ""
    var participants:Int = 0
    var random = false
    
    var categories = ["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    {
        didSet {
            activitiesTableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activitiesTableView.dataSource = self
        self.activitiesTableView.delegate = self
        self.activitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func shuffleActionButton(_ sender: UIButton) {
        random = true
        performAndQueue()
    }

    //Protocol UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = categories[indexPath.row].capitalized
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionViewController =  CategoryViewController()
        questionViewController.delegate = self
        questionViewController.activityType = categories[indexPath.row]
        questionViewController.participants = participants
        questionViewController.random = random
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func passingDataToCategoryViewController(category:String){
        let questionViewController =  CategoryViewController()
        questionViewController.delegate = self
        questionViewController.participants = participants
        questionViewController.random = random
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    func performAndQueue(){
        perform(#selector(passingDataToCategoryViewController), with: nil)
    }
}

protocol DataDelegate {
}
