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
			url: "https://github.com/JioMeet/JioMeetJCWatchPartyTemplateSDK_iOS/raw/release/1.1.18/libs/1/JioMeetCoreSDK.xcframework.zip",
			checksum: "2a51d1ea1cc997057fbee3d642a9302fb341857417e852ab32ab76af88dc4e9e"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://github.com/JioMeet/JioMeetJCWatchPartyTemplateSDK_iOS/raw/release/1.1.18/libs/1/JioMeetWatchParty.xcframework.zip",
			checksum: "dc3839bda65d232efdb88a71332fd9c56c8e4b2737262a65aa6b56817df042b0"
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
