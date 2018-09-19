## WastonEats
### To watch the demo click on the image
[![Watch the video](https://raw.githubusercontent.com/omarfoz/watsonEat/master/watsoneatsss1.png)](https://youtu.be/gxFah_HV-l4)

In this developer experience, we will create an iOS mobile app using Swift, Watson Assistant and Google Places API. The Watson Assistant service will be used to be a Chabot. The Google Places API will use to locate the nearby restaurant and coffee.


When the reader has completed this experience, they will understand how to:
*	Create a Chabot mobile app that can use to find the nearby restaurant and coffee.
*	Use Google Place API to locate the nearby restaurant and coffee.




## Flow
![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/Picture1.png)
* 1- The user opens the iOS application then click start chat
* 2- User type “Restaurant or Coffee” via the mobile app.
* 3- Watson Assistant identified the word then active the action method to find nearby.
* 4- Google Places API search nearby restaurant or coffee.
* 5- Return the nearby result.


[![](https://img.shields.io/badge/bluemix-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-ios_swift-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)

### Table of Contents

* [Summary](#summary)
* [Requirements](#requirements)
* [Configuration](#configuration)
* [Run](#run)
* [License](#license)

### Summary
Create a Mobile App that helps you to find the nearest restaurant and coffee with Watson Assistant and Google Places API:

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
## Clone this repo 
Clone this repo called "VirtualAssistantforiOSSideProject"
## Create your own Starterkit from IBM Cloud on here 
![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/watsonasstant.gif)

https://console.bluemix.net/developer/appledevelopment/starter-kits/virtual-assistant-for-ios-with-watson
* you only need one file from the starterkit called "BMSCredentials.plist"
then move this file inside the project folder watsonEats/VirtualAssistantforiOSSideProject.

* change the Bundle Identifier to anything 
in the xcode in genral tap you can change it.
## Launch Watson Assistint Tool 
import json file "WatsonEats.json" to you workspaces

![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/toolwatson.gif)

## set up Google API 
You only need the API key For google place.
* You can get google place and api key from here https://developers.google.com/places/ios-sdk/start
by creating project in google and follow the instructions 
* Plase the api key on Xcode "Keys.swift"  

![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/keys.gif)

## Finally you can run the app
You can now run the application on a simulator or physical device


### License
This package contains code licensed under the Apache License, Version 2.0 (the "License"). You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 and may also view the License in the LICENSE file within this package.
# WatsonEat
