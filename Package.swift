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
			.exact("4.3.3")
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
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_1_1_19_2/JioMeetCoreSDK.xcframework.zip",
			checksum: "bcd0d60ff6b568d047ce116350e18f04d362c108db63509b98aa356978b5988f"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_1_1_19_2/JioMeetWatchParty.xcframework.zip",
			checksum: "ebc585ebb58b52c46d2930343f6e0b418dddd9e71972e5cc80a056a9be3855b7"
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
