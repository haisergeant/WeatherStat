//
//  WeatherPresenterTests.swift
//  WeatherStatTests
//
//  Created by Le Thanh Hai on 11/24/17.
//  Copyright © 2017 haile. All rights reserved.
//

@testable import WeatherStat

import Quick
import Nimble

class WeatherPresenterTests: QuickSpec {
    class WeatherPresenterOutputSpy: WeatherPresenterOutput {
        var displayModelCalled = false
        var viewModel: WeatherViewModel?
        func display(viewModel: WeatherViewModel) {
            self.displayModelCalled = true
            self.viewModel = viewModel
        }
        
        var displayErrorCalled = false
        var error: String?
        func displayError(error: String) {
            self.displayErrorCalled = true
            self.error = error
        }
    }
    
    override func spec() {
        describe("WeatherPresenter") {
            var sut: WeatherPresenter!
            var output: WeatherPresenterOutputSpy!
            
            beforeEach {
                sut = WeatherPresenter()
                output = WeatherPresenterOutputSpy()
                sut.output = output
            }
            
            it("parse sample data") {
                if let weather = SampleData.sampleData() {
                    sut.present(response: WeatherResponse(weather: weather))
                    
                    expect(output.displayModelCalled) == true
                    expect(output.viewModel).toNotEventually(beNil())
                }
            }
            
            it("") {
                sut.presentError(error: "This is error")
                
                expect(output.displayErrorCalled) == true
                expect(output.error) == "This is error"
            }
        }
    }
}

class SampleData {
    class func sampleData() -> Weather? {
        guard let path = Bundle(for: WeatherPresenterTests.self).path(forResource: "sample", ofType: "txt") else {
            return nil
        }
        let sample = try? NSData(contentsOfFile: path) as Data

        if let sample = sample {
            guard let mainDict = try? JSONSerialization.jsonObject(with: sample, options: .allowFragments) as? NSDictionary else {
                return nil
            }
            guard let main = mainDict else {
                return nil
            }
            return Weather(dictionary: main)
        } else {
            return nil
        }
    }
}
