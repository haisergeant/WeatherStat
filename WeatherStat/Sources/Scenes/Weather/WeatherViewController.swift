//
//  WeatherViewController.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright (c) 2017 haile. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol WeatherViewControllerInput {
    func display(viewModel: WeatherViewModel)
}

protocol WeatherViewControllerOutput {
    func load(request: WeatherRequest)
}

class WeatherViewController: BaseViewController, WeatherViewControllerInput {
    var output: WeatherViewControllerOutput!
    var router: WeatherRouter!
    
    // MARK: - Object lifecycle
    override func configureSubviews() {
        super.configureSubviews()
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    
    
    func display(viewModel: WeatherViewModel) {
        
    }
}
