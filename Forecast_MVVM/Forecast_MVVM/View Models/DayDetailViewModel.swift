//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Scott Cox on 6/7/22.
//

import Foundation
import UIKit

protocol DayDetailViewDelegate: DayDetailsViewController {
    func updateViews()
}

class DayDetailViewModel {
    
    var forcastData: TopLevelDictionary?
    var days: [Day] = []
    private let networkingController: NetworkingController
    private weak var delegate: DayDetailViewDelegate?
    
    
    // MARK: - ???????? I dont know if this is right
    init(delegate: DayDetailViewDelegate, networkController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkController
        fetchForecastData()
    }
    
    private func fetchForecastData() {
        NetworkingController.fetchDays { result in
            switch result {
            case .success(let forcastData):
                self.forcastData = forcastData
                self.days = forcastData.days
                self.delegate?.updateViews()
            case .failure(let error):
                print(error)
            }
        }
    }
}
