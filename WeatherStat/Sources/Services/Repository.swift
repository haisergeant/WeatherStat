//
//  Repository.swift
//  PlayerStat
//
//  Created by Le Thanh Hai on 11/15/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

protocol Repository {
    func weatherForecast(latitude: CGFloat, longitude: CGFloat) -> SignalProducer<Weather, NSError>
}
