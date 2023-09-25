//
//  PartyManager.swift
//  JioMeetJCWatchPartyDemo
//
//  Created by Atinderpal Singh on 25/09/23.
//

import Foundation
import JioMeetWatchParty
import AVFoundation

class PartyManager: NSObject {
    static let instance = PartyManager()
    let viewModel = JVWatchPartyViewModel()
    
    override init() {
        super.init()
        let isUserLoggedIn = UserDefaults.standard.value(forKey: "isUserLoggedIN") as? Bool ?? false
        if isUserLoggedIn {
            viewModel.setUserType(type: .loggedIn(userName: "John"))
        } else {
            viewModel.setUserType(type: .guest)
        }
        // viewModel.setUserType(isGuestUser: !isUserLoggedIn)
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruptNotification(notification:)), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
    }
    
    @objc private func handleInterruptNotification(notification: NSNotification) {
        
    }
    
    func setMeetingData(meetingID: String, meetingPIN: String, ownerName: String) {
        viewModel.setMeetingData(meetingID: meetingID, meetingPIN: meetingPIN, ownerName: ownerName)
    }
    
    
}
