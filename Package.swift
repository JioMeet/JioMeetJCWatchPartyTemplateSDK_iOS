// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "JioMeetSDK",
	defaultLocalization: "en",
	platforms: [.iOS(.v13)],
	products: [
		.library(
			name: "JVWatchPartySDK",
			targets: ["JioMeetWatchPartyTarget"]
		),
	],
	dependencies: [
		.package(
			name: "JioMeetRtcEngine_iOS",
			url: "https://github.com/JioMeet/JioMeet-rtc-engine-ios.git",
			.upToNextMajor(from: "3.7.2")
		),
		.package(
			name: "Lottie",
			url: "https://github.com/airbnb/lottie-spm.git",
			.upToNextMajor(from: "4.3.3")
		),
		.package(
			name: "Starscream",
			url: "https://github.com/daltoniam/Starscream.git",
			.upToNextMajor(from: "4.0.6")
		),
		.package(
			name: "FLAnimatedImage",
			url: "https://github.com/Flipboard/FLAnimatedImage.git",
			.upToNextMajor(from: "1.0.17")
		),
		.package(
			name: "JioMeetMediaStackSDK",
			url: "https://github.com/JioMeet/JMMediaStackSDK_iOS.git",
			.upToNextMajor(from: "0.0.2")
		)
	],
	targets: [
		.binaryTarget(
			name: "JioMeetCoreSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_0_alpha_1/JioMeetCoreSDK.xcframework.zip",
			checksum: "2b711ff93cff1c78688193dc5f0002a12fa881a0737ba340ea040329e59b4376"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_0_alpha_1/JioMeetWatchParty.xcframework.zip",
			checksum: "db88ea028bce62d83ad70770ec928c305872476e25ed1d4f2494409b8a97e17b"
		),
		.target(
			name: "JioMeetWatchPartyTarget",
			dependencies: [
				.target(name: "JioMeetCoreSDK"),
				.target(name: "JioMeetWatchParty"),
				.product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
				.product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
				.product(name: "Lottie", package: "Lottie"),
				.product(name: "Starscream", package: "Starscream"),
				.product(name: "FLAnimatedImage", package: "FLAnimatedImage"),
				.product(name: "JioMeetMediaStackSDK", package: "JioMeetMediaStackSDK")
			],
			path: "Framework/Dependency",
			exclude: []
		),
	]
)
