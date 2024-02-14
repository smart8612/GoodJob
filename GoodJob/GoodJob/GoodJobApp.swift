//
//  GoodJobApp.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI
import FirebaseCore


@main
struct GoodJobApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    
}


final class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    // 로컬 빌드인지 Xcode Cloud에서의 빌드인지 판별
    let isLocalBuild = ProcessInfo.processInfo.environment["XCODE_CLOUD_BUILD"] == nil

    if isLocalBuild {
        // 로컬 빌드일 경우, GoogleService-Info.plist 파일을 사용하여 Firebase SDK 초기화
        FirebaseApp.configure()
    } else {
        // Xcode Cloud에서의 빌드일 경우, 환경 변수에서 GoogleService-Info.plist 파일의 내용을 읽어와 Firebase SDK 초기화
        guard let googleServiceInfoPlist = ProcessInfo.processInfo.environment["GOOGLE_SERVICE_INFO_PLIST"],
            let data = googleServiceInfoPlist.data(using: .utf8),
            let string = String(data: data, encoding: .utf8),
            let firebaseOptions = FirebaseOptions(contentsOfFile: string)
        else {
          fatalError("Failed to load Firebase options from environment variable")
        }
      
        FirebaseApp.configure(options: firebaseOptions)
    }
      
    return true
  }
    
}
