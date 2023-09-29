//
//  DemoView.swift
//  JVWatchParty
//
//  Created by Rohit41.Kumar on 02/05/23.
//

import SwiftUI
import AVFoundation
import JioMeetWatchParty

@available(iOS 14.0, *)
struct DemoView: View {
	@State var meetingID: String = ""
	@State var meetingPIN: String = ""
	@State var ownerName: String = ""
	@State var showMeetingInputAlert: Bool = false
	@State private var isShowPartyNavigationView = false
	
	init(setAudioSession: Bool) {
		if setAudioSession {
			let audioSession = AVAudioSession.sharedInstance()
			do {
				try audioSession.setCategory(.playback, mode: .moviePlayback, options: [.mixWithOthers])
			} catch {
				print("Failed to Set Audio Session")
			}
		}
	}
	
	var body: some View {
		NavigationView {
			ZStack(alignment: .center) {
				if showMeetingInputAlert {
					createMeetingInputView()
				} else {
					createContentView()
				}
			}
			.navigationTitle("Demo Screen")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
	
	@ViewBuilder
	private func createContentView() -> some View {
		VStack(alignment: .center, spacing: 25) {
			Text("Select a Demo Flow")
				.font(Font.system(size: 18, weight: .medium))
			
			NavigationLink {
				PartyView()
			} label: {
				Text("Start a New WatchParty")
					.foregroundColor(.white)
					.font(Font.system(size: 18, weight: .semibold))
			}.frame(width: 250)
				.padding(.top, 15)
				.padding(.bottom, 15)
				.background(Color.blue)
				.cornerRadius(10)
				
			NavigationLink(
				destination: PartyView(),
				isActive: $isShowPartyNavigationView
			) {
				EmptyView()
			}
			
			Button {
				showMeetingInputAlert = true
			} label: {
				Text("Join a WatchParty")
					.foregroundColor(.white)
					.font(Font.system(size: 18, weight: .semibold))
			}
			.frame(width: 250)
			.padding(.top, 15)
			.padding(.bottom, 15)
			.background(Color.blue)
			.cornerRadius(10)
		}
	}
	
	@ViewBuilder
	private func createMeetingInputView() -> some View {
		VStack(alignment: .center, spacing: 0) {
			Text("Enter Meeting ID and PIN")
				.font(Font.system(size: 18, weight: .semibold))
				.multilineTextAlignment(.leading)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading, 20)
				.padding(.bottom, 30)
			
			Divider()
			
			TextField("Enter Meeting ID", text: $meetingID)
				.font(Font.system(size: 16, weight: .medium))
				.frame(height: 40)
				.padding(.leading, 20)
				.keyboardType(.numberPad)
				.autocorrectionDisabled()
			
			Divider().padding(.leading, 20)
			
			TextField("Enter Meeting PIN", text: $meetingPIN)
				.font(Font.system(size: 16, weight: .medium))
				.frame(height: 40)
				.padding(.leading, 20)
				.keyboardType(.namePhonePad)
				.autocorrectionDisabled()
			
			Divider().padding(.leading, 20)
			
			TextField("Enter Owner Name", text: $ownerName)
				.font(Font.system(size: 16, weight: .medium))
				.frame(height: 40)
				.padding(.leading, 20)
				.keyboardType(.namePhonePad)
				.autocorrectionDisabled()
			
			Divider()
			
			Button {
				PartyManager.instance.setMeetingData(meetingID: meetingID, meetingPIN: meetingPIN, ownerName: ownerName)
				isShowPartyNavigationView = true
				showMeetingInputAlert = false
			} label: {
				Text("Join")
					.foregroundColor(.white)
					.font(Font.system(size: 18, weight: .semibold))
			}
			.frame(width: 250, height: 45)
			.background(Color.blue)
			.cornerRadius(10)
			.padding(.top, 40)
			
			Button {
				showMeetingInputAlert = false
			} label: {
				Text("Cancel")
					.foregroundColor(.white)
					.font(Font.system(size: 18, weight: .semibold))
			}
			.frame(width: 250, height: 45)
			.background(Color.red)
			.cornerRadius(10)
			.padding(.top, 20)

		}
	}
}

@available(iOS 14.0, *)
struct DemoView_Previews: PreviewProvider {
	static var previews: some View {
		DemoView(setAudioSession: true)
	}
}



