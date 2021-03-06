## WastonEats
### Click the image to watch the demo.
[![Watch the video](https://raw.githubusercontent.com/omarfoz/watsonEat/master/watsoneatsss.png)](https://youtu.be/gxFah_HV-l4)

In this developer experience, we will create an iOS mobile app using Swift, Watson Assistant and Google Places API. The Watson Assistant service will be used as a Chabot. The Google Places API will use to locate the nearby restaurants and coffee.


When the reader has completed this experience, they will understand how to:
*	Create a Chabot mobile app that can be used to find the nearby restaurants and coffee.
*	Use Google Places API to locate the nearby restaurants and coffee.




### Flow
![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/Picture1.png)

1- The user opens the iOS application then clicks start chat.

2- User types “Restaurant or Coffee” via the mobile app.

3- Watson Assistant identifies the word then activates the action method.

4- Google Places API searches nearby restaurants or coffee.

5- Return the nearby results.


[![](https://img.shields.io/badge/bluemix-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-ios_swift-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)

### Table of Contents

* [Summary](#summary)
* [Requirements](#requirements)
* [Configuration](#configuration)
* [Run](#run)
* [License](#license)

### Summary
A Mobile Application that helps you find the nearest restaurants and coffee with Watson Assistant and Google Places API.

### Requirements
* iOS 9.0+
* Xcode 9
* Swift 4.0

### Configuration
* [IBM Cloud Mobile services Dependency Mangagement](#ibm-cloud-mobile-services-dependency-management)
* [Watson Dependency Management](#watson-dependency-management)


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
* 1- After you're done from the [Configuration](#configuration)
* 2- [Create Starterkit from IBM Cloud](#create-your-own-starterkit-from-ibm-cloud)
* 3- [Set up Goople API](#set-up-google-api)
* 4- [Run the app](#finally-run-the-app)

#### Create your own Starterkit from IBM Cloud 
[Starterkit-Virtual Assistant for iOS with Watson](https://console.bluemix.net/developer/appledevelopment/starter-kits/virtual-assistant-for-ios-with-watson)

![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/watsonasstant.gif)


* You only need one file from the starterkit called "BMSCredentials.plist",
then move this file inside the project folder watsonEats/VirtualAssistantforiOSSideProject.

* Change the *Bundle Identifier* to anything 
in the xcode in *Genral* tab you can change it.
##### Launch Watson Assistint Tool 
Import json file "WatsonEats.json" to your workspaces, you can find the json file in the project WatsonEats/

![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/toolwatson.gif)

#### Set up Google API 
You only need the API key for *Google Places*.
* You can get *Google Places* API key from [here](https://developers.google.com/places/ios-sdk/start),
by creating project in google and following the instructions.
* Place the API key on Xcode "Keys.swift"  

![alt text](https://raw.githubusercontent.com/omarfoz/sideproject-watsonEat/master/keys.gif)

#### Finally Run The App
You can now run the application on a simulator or physical device.


### License
This package contains code licensed under the Apache License, Version 2.0 (the "License"). You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 and may also view the License in the LICENSE file within this package.
# WatsonEats
