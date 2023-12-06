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
			checksum: "bd79c3f096dae55d842115ab0a928ec37cbb2df42ca413fe9a269a8499624067"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_0_alpha_2/JioMeetWatchParty.xcframework.zip",
			checksum: "91ec9635ab3b0b8c664a844027ae74e06f607d32c3c19a509978772c4b603556"
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
