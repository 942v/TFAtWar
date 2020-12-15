# Transformes at war (TFAtWar)

The Transformers are at war and you are in charge of settling the score! This application evaluates who wins a fight between the Autobots and the Decepticons.

Wanna know more? 
Watch this [videol](https://www.youtube.com/watch?v=nLS2N9mHWaw)

Really fun weekend project! 

## Setup
This project is devided in 4 project-libraries and 1 client project.
Uses cocoapods as dependency manager.
In order to be able to run it you need to do a pod install on the client folder.
Once the pod install has ended you can open the TFAtWar.xcworkspace

You can also compile each project library by itself by doing a pod install on the example folder inside each dependency and opening the [LibName].xcworkspace 

## Libs
- TFCommonKit: Lib that handles all logic common to any SO client. Like the view models, responders, navigators.
- TFData: All networking and data managment 
- TFiOSKit: Lib where all UIKit components are stored
- TFWarEngine: The engine with all the rules for the battle between autobots and decepticons

## Requirements
- Cocoapods: 1.9.1 or higher
- Should run with any Xcode version that includes at least swift 5.1. It was developed with Xcode 12.2

## Assumptions
- If the battle ends in a of the numbers of wins then all died! 
- We don't validate locally the data to create or edit a transformer.
- You have Xcode installed :P

## Unit Tests
To run them you can do it in the client project or in the lib project.

- [ ] TFCommonKit
- [ ] TFData
- [ ] TFiOSKit
- [x] TFWarEngine 

## Missing things
- Order and finish the podspecs. We could create subspecs and finish the regular setup to make them lint
- Test view models :/ 
- Test UI

