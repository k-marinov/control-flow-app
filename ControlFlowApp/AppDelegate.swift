//
//  AppDelegate.swift
//  ControlFlowApp
//
//  Created by Keran Marinov on 02/10/2020.
//  Copyright © 2020 KM LTD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        loadConfiguration()
        findState()
        displayMatchingCars()
        setUpVideoState()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


    private func loadConfiguration() {
        let isProduction = true

        when(isProduction)
            .then { print("production configuration is loaded") }
            .else { print("debug configuration is loaded") }
    }

    @discardableResult
    private func findState() -> Int {
        let isProduction = false
        let state = when(isProduction)
            .then(1)
            .else(0)
        print("state=", state)
        return state
    }


    @discardableResult
    private func displayAgeInstructions() -> String {
        let age = 40
        let banner = when(age > 40)
            .then("Consider buying AUDI RS6 Avant!")
            .else("Stick to Ford Focus!")
        print("banner=", banner)
        return banner
    }

    private func displayMatchingCars() {
        let age = 40
        when(age)
            .greater(than: 50) { print("Bentley") }
            .greaterThan(orEqual: 40) { print("AUDI RS6") } /// prints
            .equal(to: 40) { print("AUDI A3") } /// prints
            .equal(to: 20) { print("Ford Fiesta") }
            .lower(than: 10) { print("Toy Car") }
            .lowerThan(orEqual: 10) { print("No Car") }
            .else { print("Cyber Truck") }

        let newAge = 0
        when(newAge)
            .greater(than: 50) { print("Bentley") }
            .greaterThan(orEqual: 40) { print("AUDI RS6") }
            .equal(to: 40) { print("AUDI A3") }
            .equal(to: 20) { print("Ford Fiesta") }
            .in(0...5) { print("Remote Controlled Cars") }
            .not(in: 0...5) { print("Metal Cars") }
            .found(in: [0, 1]) { print("Electric Bike!") }
            .in(0..<5) { print("Bike") }
            .not(in: 0..<5) { print("Trolley") }
            .else { print("Cyber Truck!!!") }
    }


    private func setUpVideoState() {
        enum VideoState {
            case pause
            case play
            case stop
        }
        let state = VideoState.pause
        let value: Int = when(state)
            .case(.pause) { 5 }
            .case(.pause) { 1 }
            .case(.play) { 2 }
            .case(.stop) { 3 }
            .else { -1 }

        print("value is ", value)
    }

}

