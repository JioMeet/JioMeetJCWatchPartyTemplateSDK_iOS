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
			.branch("v_3_0_2")
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
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_2/JioMeetWatchParty.xcframework.zip",
			checksum: "aedbd9c933076d0362d3a96c412c262a702a88545c37e7c5487476e2b9b824d6"
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
