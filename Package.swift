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
            name: "SwiftyJSON",
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            .upToNextMajor(from: "5.0.1")
        ),
		.package(
            name: "SocketIO",
            url: "https://github.com/socketio/socket.io-client-swift.git", 
           .upToNextMajor(from: "16.1.0")
        ),
		.package(
            name: "MMWormhole",
            url: "https://github.com/JioMeet/MMWormhole.git",
            .upToNextMajor(from: "2.1.0")
        ),
        .package(
            name: "VoiceActivityDetector",
            url: "https://github.com/JioMeet/WebRtcVad.git",
            .exact("1.0.0")
        ),
		.package(
			name: "JioMeetRtcEngine_iOS",
			url: "https://github.com/JioMeet/JioMeet-rtc-engine-ios.git",
			.exact("3.7.2")
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
			name: "JMMediaStackSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/spm_demo_2/JMMediaStackSDK.xcframework.zip",
			checksum: "f12392b08615e7716aca762c60b707594b0e65ddc3ae46d72f97537e590c94ea"
		),
		.binaryTarget(
			name: "JioMeetCoreSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/spm_demo_2/JioMeetCoreSDK.xcframework.zip",
			checksum: "cc37a8717dab972327ccf5b0b5532c70b400b8ec1a2e0df6975d94d29866b669"
		),
		.binaryTarget(
			name: "JioMeetWatchParty",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/spm_demo_2/JioMeetWatchParty.xcframework.zip",
			checksum: "75c5831e08862ac5c8e93145c5fa6f59e54251cf7d1206f6d8958db9e5aecfa6"
		),
		.target(
			name: "JioMeetWatchPartyTarget",
			dependencies: [
				.target(name: "JMMediaStackSDK"),
				.target(name: "JioMeetCoreSDK"),
				.target(name: "JioMeetWatchParty"),
				.product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "SocketIO", package: "SocketIO"),
                .product(name: "MMWormhole", package: "MMWormhole"),
                .product(name: "VoiceActivityDetector", package: "VoiceActivityDetector"),
				.product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
				.product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
				.product(name: "Lottie", package: "Lottie"),
				.product(name: "FLAnimatedImage", package: "FLAnimatedImage")
			],
			path: "Framework/Dependency",
			exclude: []
		),
	]
)
