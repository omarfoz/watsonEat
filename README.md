## Virtual Assistant for iOS with Watson

[![](https://img.shields.io/badge/bluemix-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-ios_swift-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)

### Table of Contents
* [Summary](#summary)
* [Requirements](#requirements)
* [Configuration](#configuration)
* [Run](#run)
* [License](#license)

### Summary
This IBM Cloud Starter Kit will showcase the Watson Assistant service and give you integration points for each of the IBM Cloud Mobile services.

### Requirements
* iOS 9.0+
* Xcode 9
* Swift 4.0

### Configuration
* [IBM Cloud Mobile services Dependency Mangagement](#bluemix-mobile-services-dependency-management)
* [Watson Dependency Management](#watson-dependency-management)
* [Watson Credential Mangement](#watson-credential-management)

#### IBM Cloud Mobile services Dependency Management
The IBM Cloud Mobile services SDK uses [CocoaPods](https://cocoapods.org/) to manage and configure dependencies.

You can install CocoaPods using the following command:

```bash
$ sudo gem install cocoapods
```

If the CocoaPods repository is not configured, run the following command:

```bash
$ pod setup
```

For this starter, a pre-configured `Podfile` has been provided. To download and install the required dependencies, run the following command in your project directory:

```bash
$ pod install
```
Now Open the Xcode workspace: `{APP_Name}.xcworkspace`. From now on, open the `.xcworkspace` file because it contains all the dependencies and configurations.

If you run into any issues during the pod install, it is recommended to run a pod update by using the following commands:

```bash
$ pod update
$ pod install
```

> [View configuration](#configuration)

#### Watson Dependency Management
This starter uses the Watson Developer Cloud iOS SDK in order to use the Watson Assistant service.

The Watson Developer Cloud iOS SDK uses [Carthage](https://github.com/Carthage/Carthage) to manage dependencies and build binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/):

```bash
$ brew update
$ brew install carthage
```

To use the Watson Developer Cloud iOS SDK in any of your applications, specify it in your `Cartfile`:

```
github "watson-developer-cloud/swift-sdk"
```

For this starter, a pre-configured `Cartfile` has been included.

Run the following command to build the dependencies and frameworks:

```bash
$ carthage update --platform iOS
```

> **Note**: You may have to run `carthage update --platform iOS --no-use-binaries`, if the binary is a lower version than your current version of Swift.

Once the build has completed, the frameworks can be found in the **Carthage/Build/iOS/** folder. The Xcode project in this starter already includes framework links to the following frameworks in this directory:

* **AssistantV1.framework**

If you build your Carthage frameworks in a separate folder, you will have to drag-and-drop the above frameworks into your project and link them in order to run this starter successfully.

> [View configuration](#configuration)

#### Training Watson
Remember you need to Open the Watson Training user experience from the IBM Console before you can run the app locally. This automatically prepares training before the app connects to the Watson Assistant.


> [View configuration](#configuration)

### Run
You can now run the application on a simulator or physical device


The Watson Assistant service allows you to add a natural language interface to your application to automate interactions with your end users. This application shows how to incorporate Watson Assistant into an iOS application.

### License
This package contains code licensed under the Apache License, Version 2.0 (the "License"). You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 and may also view the License in the LICENSE file within this package.
# sideproject-watsonEat
