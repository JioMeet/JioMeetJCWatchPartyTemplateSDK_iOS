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
			name: "JioMeetCoreSDK",
			url: "https://github.com/JioMeet/JioMeetCoreSDK_iOS.git",
			.upToNextMajor(from: "3.0.0-alpha.1")
		),
		.package(
			name: "Lottie",
			url: "https://github.com/airbnb/lottie-spm.git",
			.exact("4.3.3")
		),
		.package(
			name: "FLAnimatedImage",
			url: "https://github.com/Flipboard/FLAnimatedImage.git",
			from: "1.0.17"
		)
	],
	targets: [
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_7/JioMeetWatchParty.xcframework.zip",
			checksum: "15090a280fbd8a62e19f5632020cb7cf9d410ff35aafa41a01b904d0fd153322"
		),
		.target(
			name: "JioMeetWatchPartyTarget",
			dependencies: [
				.target(name: "JioMeetWatchParty"),
				.product(name: "Lottie", package: "Lottie"),
				.product(name: "FLAnimatedImage", package: "FLAnimatedImage"),
				.product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "Framework/Dependency",
			exclude: []
		),
	]
)
