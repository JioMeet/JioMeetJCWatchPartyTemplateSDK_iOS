//
//  PartyView.swift
//  JVWatchParty
//
//  Created by Rohit41.Kumar on 02/05/23.
//

import SwiftUI
import AVFoundation
import AVKit
import JioMeetCoreSDK
import JioMeetWatchParty
import MediaPlayer

class ShareInfo {
	static let instance = ShareInfo()
	var meetingID = ""
	var meetingPIN = ""
	var ownerName = ""
}

@available(iOS 14.0, *)
struct PartyView: View {
	@Environment(\.openURL) var openURL
	@AppStorage("isUserLoggedIN") private var isUserLoggedIn = false
	@State private var isShareSheetPresented = false
	@State var randomNumber: Int = 0
	@State var selectedIndex: Int = 1
	@State var showUserLoginView = false
	@State private var soundLevel: Float = 0.5
	@State var player = AVPlayer(
		url: URL(
			string: "https://moctobpltc-i.akamaihd.net/hls/live/571329/eight/playlist.m3u8"
		)!
	)
		
	init(meetingID: String = "", meetingPIN: String = "", ownerName: String = "") {
	}
	
	var body: some View {
		GeometryReader { (reader) in
			VStack(spacing: 0) {
				VideoPlayer(player: player) {
					
				}
				.frame(height: getPlayerHeight(readerSize: reader.size))
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
						self.player.play()
					}
				}
				
				ZStack(alignment: .center) {
					Color.yellow
					Text("AD View")
						.foregroundColor(.white)
						.font(Font.system(size: 15, weight: .bold))
				}.frame(height: 50)
				
				HStack(alignment: .center) {
					Button {
						selectedIndex = 0
					} label: {
						Text("TAB 1")
							.foregroundColor(.white)
							.font(Font.system(size: 16, weight: .medium))
					}.frame(maxWidth: .infinity)
					
					Button {
						selectedIndex = 1
					} label: {
						Text("WatchParty")
							.foregroundColor(.white)
							.font(Font.system(size: 16, weight: .medium))
					}.frame(maxWidth: .infinity)
					
					Button {
						selectedIndex = 2
					} label: {
						Text("TAB 3")
							.foregroundColor(.white)
							.font(Font.system(size: 16, weight: .medium))
					}.frame(maxWidth: .infinity)

				}.frame(
					width: reader.size.width,
					height: 40,
					alignment: .center
				).background(Color.black)
				Divider()
				
				if selectedIndex == 0 {
					Text("TAB 1 Content View")
						.foregroundColor(.white)
						.font(Font.system(size: 22, weight: .semibold))
						.edgesIgnoringSafeArea(.all)
						.padding(.top, 30)
						
				} else if selectedIndex == 1 {
					ZStack(alignment: .center) {
						JVWatchPartyView {
                            // Pass JWT token to start meeting.
                            sendJWTTokenNotification(token: "")
						} onPressTermsAndConditionLink: { (url) in
							guard let strongURL = url else { return }
							openURL(strongURL)
						} onRequestToShareInvite: { (meetingID, meetingPin, ownerName) in
                            ShareInfo.instance.meetingID = meetingID
							ShareInfo.instance.meetingPIN = meetingPin
							ShareInfo.instance.ownerName = ownerName
							isShareSheetPresented = true
						} onRequiredToChangeMediaPlayerVolume: { newLevel in
                            player.volume = newLevel
						} onRequestForUserLogin: {
							showUserLoginView = true
						} onRequestToSendAnalyticsEvent: { (event) in
							
							print(event.eventData)
						}
						//.edgesIgnoringSafeArea(.all)
						.environmentObject(PartyManager.instance.viewModel)
						
						if showUserLoginView {
							LoginView {
								showUserLoginView = false
							} onSuccessfullLogin: {
								showUserLoginView = false
								isUserLoggedIn = true
								PartyManager.instance.viewModel.setUserType(type: .loggedIn(userName: "John"))
							}.edgesIgnoringSafeArea(.all)

						}
					}
				} else {
					Text("TAB 3 Content View")
						.foregroundColor(.white)
						.font(Font.system(size: 22, weight: .semibold))
						.padding(.top, 30)
						.edgesIgnoringSafeArea(.all)
				}
			}
		}
		.frame(
			minWidth: 0,
			maxWidth: .infinity,
			minHeight: 0,
			maxHeight: .infinity
		).background(Color.black)
		.navigationBarHidden(true)
		.onAppear {
			print("LOGS ::: Main App ::: Party View Appears")
		}
		.sheet(isPresented: $isShareSheetPresented) {
			let initialMessage = "Hey! I just started a Watch Party on JioCinema."
			let meetingIdInfo = "Meeting ID: \(ShareInfo.instance.meetingID)"
			let meetingPinInfo = "Meeting PIN: \(ShareInfo.instance.meetingPIN)"
			let ownerName = "Owner Name: \(ShareInfo.instance.ownerName)"
			
			let linkString = String(
				format: "com.jio.wp://watchparty?meetingid=%@&pin=%@&owner=%@",
				ShareInfo.instance.meetingID,
				ShareInfo.instance.meetingPIN,
				ShareInfo.instance.ownerName
			)
			
			let message = [initialMessage, meetingIdInfo, meetingPinInfo, ownerName].joined(separator: "\n")
			ShareSheetView(activityItems: [message])
		}
	}
	
	private func getPlayerHeight(readerSize: CGSize) -> CGFloat {
		return ((readerSize.width * 204) / 360)
	}
	
    
	
	private func sendJWTTokenNotification(token: String) {
		NotificationCenter.default.post(
			name: NSNotification.Name.init(JVWatchPartyNotificationName.jwtTokenToCreateParty.rawValue),
			object: nil,
			userInfo: ["jwtToken": token]
		)
	}
     
}

@available(iOS 14.0, *)
struct PartyView_Previews: PreviewProvider {
	static var previews: some View {
		PartyView(meetingID: "", meetingPIN: "", ownerName: "")
	}
}


extension MPVolumeView {
	static func setVolume(_ volume: Float) -> Void {
		let volumeView = MPVolumeView()
		let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
			slider?.value = volume
		}
	}
}


struct ShareSheetView: UIViewControllerRepresentable {
	typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
	let activityItems: [Any]
	let applicationActivities: [UIActivity]? = nil
	let excludedActivityTypes: [UIActivity.ActivityType]? = nil
	let callback: Callback? = nil
	func makeUIViewController(context: Context) -> UIActivityViewController {
		let controller = UIActivityViewController(
			activityItems: activityItems,
			applicationActivities: applicationActivities)
		controller.excludedActivityTypes = excludedActivityTypes
		controller.completionWithItemsHandler = callback
		return controller
	}
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
		// nothing to do here
	}
}
