# JioMeet JCWatchParty Template Quickstart

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Project Settings](#project-settings)
   - [Info.plist Changes](#infoplist-changes)
   - [Enable Background Mode](#enable-background-mode)
5. [Integration Steps](#integration-steps)
   - [Add SDK](#add-sdk)
   - [Import SDK](#import-sdk)
6. [Start WatchParty](#start-watchparty)
   - [Create WatchParty View Model](#create-watchparty-view-model)
   - [Add WatchParty View](#add-watchparty-view)
   - [WatchParty Preview](#watchparty-preview)

7. [Public Methods](#public-methods)
   - [Get Current WatchParty Meeting ID](#get-current-watchparty-meeting-id)
   - [Force Exit Current WatchParty](#force-exit-watchparty)
   - [Check if User is in WatchParty or Not](#check-user-in-watchparty)
   - [Set User Type](#set-user-type)
   - [Set Meeting Data](#set-meeting-data)
8. [Reference Classes](#reference-classes)
9. [Troubleshooting](#troubleshooting)

## Introduction

In this documentation, we'll guide you through the process of installation, enabling you to enhance your iOS app with Jiomeet's real-time communication capabilities swiftly and efficiently. Let's get started on your journey to creating seamless communication experiences with JioMeet JCWatchParty Template!

---

## Features

In JioMeet JCWatchParty Template UI, you'll find a range of powerful features designed to enhance your iOS application's communication and collaboration capabilities. These features include:

1. **Voice and Video Calling**: Enjoy high-quality, real-time audio and video calls with your contacts.

2. **Participant Panel**: Manage and monitor participants in real-time meetings or video calls for a seamless user experience.

3. **Group Conversation**: Easily engage in text-based conversations with multiple participants in one chat group.

4. **Share Meeting**: Easily Share meeting details with your contacts.


## Prerequisites

Before getting started with this example app, please ensure you have the following software installed on your machine:

- Xcode 14.2 or later.
- Swift 5.0 or later.
- An iOS device or emulator running iOS 13.0 or later.
- **JWTToken api from backend**

## Project Settings

### Info.plist Changes

Please add below permissions keys to your `Info.plist` file with proper description.

```swift
<key>NSCameraUsageDescription</key>
<string>Allow access to camera for meetings</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allow access to mic for meetings</string>
```

### Enable Background Mode

Please enable `Background Modes` in your project `Signing & Capibilities` tab. After enabling please check box with option `Audio, Airplay, and Pictures in Pictures`. If you don't enables this setting, your mic will be muted when your app goes to background.


## Integration Steps

### Add SDK

Please add WatchParty SDK as a dependency via Swift Package Manager and use latest release. Use below git url.

[https://github.com/JioMeet/JioMeetJCWatchPartyTemplateSDK_iOS.git](https://github.com/JioMeet/JioMeetJCWatchPartyTemplateSDK_iOS.git)

### Import SDK

Please use below import statements

```swift
import JioMeetCoreSDK
import JioMeetWatchParty
```

## Start WatchParty

### Create WatchParty View Model

First create an instance of JVWatchPartyViewModel . Make sure it should not go out of scope once UI is rerendered on state change. You can use a Singleton class and create a variable of JVWatchPartyViewModel type.
You need to assign some initial values by JVWatchPartyViewModel instance like user type (guest or logged in user), meeting ID, meeting pin and party owner name.

### Set User Type
Use setUserType method of JVWatchPartyViewModel .

### Set Meeting Data
Use setMeetingData method of JVWatchPartyViewModel .

Please take below reference.

```swift
class PartyManager: NSObject {

   static let instance = PartyManager()
   let viewModel = JVWatchPartyViewModel()

   override init() { 
      super.init()
      let isUserLoggedIn = UserDefaults.standard.value(forKey: "isUserLoggedIN") as? Bool ?? false
      if isUserLoggedIn {
         viewModel.setUserType(type: .loggedIn(userName: "John"))
      } else {
         viewModel.setUserType(type: .guest)
      }
   }

   func setMeetingData(meetingID: String, meetingPIN: String, ownerName: String) {
      viewModel.setMeetingData(
            meetingID: meetingID,
            meetingPIN: meetingPIN,
            ownerName: ownerName
      )
   }

}
```

## Add WatchParty View

Please add SDK WatchParty View in your screen. Take reference below.

```swift

JVWatchPartyView {

// SDK Request JWT Token from Parent App to create WatchParty
// Once Token is recieved, publish a notification via notification center
// Notification Name is: JVWatchPartyNotificationName.jwtTokenToCreateParty.rawValue
// Notification Payload is: ["jwtToken": JWT_TOKEN_FROM_PARENT_APP]

   NotificationCenter.default.post( name:
            NSNotification.Name.init(JVWatchPartyNotificationName.jwtTokenToCreateParty.rawValue),
            object: nil,
            userInfo: ["jwtToken": token]
    )

} onPressTermsAndConditionLink: { (url) in
   // SDK Request Parent App to open Terms and Condition URL
   // Use url value to open the URL in WebView or Device Browser guard let strongURL = url else { return }
   openURL(strongURL)
} onRequestToShareInvite: { (meetingID, meetingPin, ownerName) in // SDK Request Parent App to Show Invite View
   // SDK Will sent you meetingID, meetingPin and Party owner name. // You can use this data according to your requirement
} onRequiredToChangeMediaPlayerVolume: { newLevel in
   // SDK Request Parent App to Change Media Player Volume. // Use newLevel value to set the player volume. player.volume = newLevel
} onRequestForUserLogin: {
   // SDK force Parent App to ask user to login to continue to watchparty
   // Once Login process is done by parent app
   // Call setUserType method of WatchParty view model you created earlier PartyManager.instance.viewModel.setUserType(type: .loggedIn(userName: "John"))
} onRequestToSendAnalyticsEvent: { (event) in
   // SDK Sent Analytic data to Parent App.
   // Parent app needs to process this according to requirement
   // Use eventData property of event. It is a [Strin: Any] dictionary print(event.eventData)
}.environmentObject(PartyManager.instance.viewModel) // Set View Model you created earlier as environmentObject

```

## Watchparty Preview

## Party Started 

![party started](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/Watchparty/party_Started.png)

## Menu Setting

![menu setting](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/Watchparty/menu_setting.png)


## Public Methods

   All below methods can be called via instance of JVWatchPartyViewModel .

### Get Current WatchParty Meeting ID

   public func getCurrentPartyID() -> String

### Force Exit Current WatchParty

   public func forceLeaveCurrentWatchParty(completion: ((_ isPartyLeft: Bool) -> Void)? = nil)

### Check if User is in WatchParty or Not

   public func isUserAlreadyInParty() -> Bool

### Set User Type

   public func setUserType(type: JVPartyUserType)

### Set Meeting Data

   public func setMeetingData(meetingID: String, meetingPIN: String, ownerName: String)

## Reference Classes

   Please check `PartyView` class for integration reference.

## Troubleshooting

Facing any issues while integrating or installing the JioMeet JCWatchParty Template Kit please connect with us via real time support present in jiomeet.support@jio.com or https://jiomeetpro.jio.com/contact-us
