//
//  BrazeBannersApp.swift
//  BrazeBanners
//
//  Created by Makoto Taguchi on 2025/07/31.
//

import SwiftUI
import UIKit
import BrazeKit

@main
struct BrazeBannersApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var braze: Braze? = nil
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let configuration = Braze.Configuration(
             apiKey: "YOUR-API-KEY-HERE", // Replace with your Braze API key
             endpoint: "YOUR-SDK-ENDPOINT-HERE" // Replace with your Braze endpoint
        )
        
        configuration.logger.level = .debug // Set log level to debug for development
        
        let braze = Braze(configuration: configuration)
        AppDelegate.braze = braze
        
        braze.changeUser(userId: "myUserID")
        
        braze.banners.requestBannersRefresh(placementIds: ["header_banner","carousel_banner1"])
        
        return true
    }
}


