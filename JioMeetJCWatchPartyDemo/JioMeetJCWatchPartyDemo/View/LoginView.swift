//
//  LoginView.swift
//  JVWatchParty
//
//  Created by Rohit41.Kumar on 02/05/23.
//

import SwiftUI

struct LoginView: View {
	
	let onCloseView: (() -> Void)
	let onSuccessfullLogin: (() -> Void)
	
	init(
		onCloseView: @escaping () -> Void,
		onSuccessfullLogin: @escaping () -> Void
	) {
		self.onCloseView = onCloseView
		self.onSuccessfullLogin = onSuccessfullLogin
	}
	
	var body: some View {
		ZStack(alignment: .center) {
			Color.init(red: 23/255, green: 24/255, blue: 26/255)
				.edgesIgnoringSafeArea(.all)
			VStack(alignment: .center, spacing: 0) {
				Rectangle()
					.fill(Color.init(red: 116/255, green: 116/255, blue: 118/255))
					.frame(width: 50, height: 2)
					
				HStack(alignment: .center) {
					Text("Login to Continue")
						.foregroundColor(.white)
						.font(Font.system(size: 18, weight: .semibold))
						.padding(.leading, 15)
					Spacer()
					Button {
						onCloseView()
					} label: {
						Image(systemName: "multiply")
							.resizable()
							.foregroundColor(.white)
							.frame(width: 15, height: 15)
					}
					.frame(width: 25, height: 25)
					.padding(.trailing, 10)
				}.padding(.top, 25)
				
				Text("This is demo mockup. Please click on continue button for a mockup login. You will be redirected to WatchParty View once you click on continue button")
					.frame(maxWidth: .infinity, alignment: .leading)
					.font(.footnote)
					.multilineTextAlignment(.leading)
					.foregroundColor(.white)
					.padding(.leading, 15)
					.padding(.trailing, 15)
					.padding(.top, 25)
				
				Button {
					onSuccessfullLogin()
				} label: {
					Text("Continue")
						.foregroundColor(.white)
						.font(Font.system(size: 18, weight: .semibold))
				}
				.frame(width: 250, height: 48)
				.background(Color(red: 217/255, green: 0, blue: 141/255))
				.cornerRadius(24)
				.padding(.top, 25)
				
			}.frame(
				minWidth: 0,
				maxWidth: .infinity,
				minHeight: 0,
				maxHeight: .infinity,
				alignment: .top
			)
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView {
			
		} onSuccessfullLogin: {
			
		}

	}
}
