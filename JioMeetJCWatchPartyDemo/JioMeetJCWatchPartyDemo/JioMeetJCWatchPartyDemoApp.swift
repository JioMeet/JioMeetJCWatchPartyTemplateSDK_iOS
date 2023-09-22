//
//  JioMeetJCWatchPartyDemoApp.swift
//  JioMeetJCWatchPartyDemo
//
//  Created by Atinderpal Singh on 22/09/23.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct JioMeetJCWatchPartyDemoApp: App {
    var body: some Scene {
        WindowGroup {
            DemoView(setAudioSession: true)
        }
    }
}
