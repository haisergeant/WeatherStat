//
//  ServerRepository.swift
//  PlayerStat
//
//  Created by Le Thanh Hai on 11/15/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Alamofire

class ServerRepository: Repository {
    static let instance = ServerRepository()
    func weatherForecast(latitude: Double, longitude: Double) -> SignalProducer<Weather, NSError> {
        return SignalProducer { observer, disposable in
            let url = String(format: URL.FORECAST_URL, URL.DARK_SKY_KEY, latitude, longitude)
            let request = Alamofire.request(url).responseJSON { response in
                if let mainDict = response.result.value as? NSDictionary {
                    let weather = Weather(dictionary: mainDict)
                    observer.send(value: weather)
                    observer.sendCompleted()
                } else if let error = response.error {
                    observer.send(error: error as NSError)
                }
            }
            _ = disposable.observeEnded {
                request.cancel()
            }
        }
    }
}
