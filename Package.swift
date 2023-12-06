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
			from: "3.7.2"
		),
		.package(
			name: "Lottie",
			url: "https://github.com/airbnb/lottie-spm.git",
			from: "4.3.3"
		),
		.package(
			name: "Starscream",
			url: "https://github.com/daltoniam/Starscream.git",
			from: "4.0.6"
		),
		.package(
			name: "FLAnimatedImage",
			url: "https://github.com/Flipboard/FLAnimatedImage.git",
			from: "1.0.17"
		)
	],
	targets: [
		.binaryTarget(
			name: "JioMeetCoreSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_0_alpha_2/JioMeetCoreSDK.xcframework.zip",
			checksum: "eb3eb3ebcd9da5d5839188e2b7199cbf149ccb400fc5a8f4a4e6441782d92acc"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_0_alpha_2/JioMeetWatchParty.xcframework.zip",
			checksum: "85af6dea8ac5f31424c9d6251698d0e4f1f5c9ca62a688afc5ba71540d4ac1f2"
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
			],
			path: "Framework/Dependency",
			exclude: []
		),
	]
)
