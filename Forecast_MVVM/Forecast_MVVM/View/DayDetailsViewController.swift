//
//  DayDetailsViewController.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
  
    
    // MARK: - Local property for the View-Model
    private var viewModel: DayDetailViewModel!
    
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Conform to the TBVS Protocols
        dayForcastTableView.delegate = self
        dayForcastTableView.dataSource = self
        
        // Set the value for the View-Model when the view has loaded.
       viewModel = DayDetailViewModel(delegate: self)
       
    }
}


//MARK: - Extensions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forcastData?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        let day = viewModel.days[indexPath.row]
        cell.updateViews(day: day)
        return cell
    }
}

extension DayDetailsViewController: DayDetailViewDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            let currentDay = self.viewModel.days[0]
            self.cityNameLabel.text = self.viewModel.forcastData?.cityName ?? "No City Found"
            self.currentDescriptionLabel.text = currentDay.weather.description
            self.currentTempLabel.text = "\(currentDay.temp)F"
            self.currentLowLabel.text = "\(currentDay.lowTemp)F"
            self.currentHighLabel.text = "\(currentDay.highTemp)F"
            self.dayForcastTableView.reloadData()
        }
    }
}

