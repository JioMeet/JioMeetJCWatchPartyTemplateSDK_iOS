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
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_2_0_9/JioMeetWatchParty.xcframework.zip",
			checksum: "6e3fecf6c98f7dd9ad3f00c8fc659c904ebf9179e9ff1e363a2582eb0c350f7b"
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
