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
			.upToNextMajor(from: "4.0.0")
		),
		.package(
			name: "Lottie",
			url: "https://github.com/airbnb/lottie-spm.git",
			.upToNextMajor(from: "4.4.3")
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
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v_4_0_2/JioMeetWatchParty.xcframework.zip",
			checksum: "75c7419b1710a42de3bcbfa5bfb7c18ab44ee5c5bc4eeafe023b376e8fe87ad2"
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
