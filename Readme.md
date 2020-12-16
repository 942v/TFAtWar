# Transformes at war (TFAtWar)

The Transformers are at war and you are in charge of settling the score! This application evaluates who wins a fight between the Autobots and the Decepticons.

Wanna know more? 
Watch this [video](https://www.youtube.com/watch?v=nLS2N9mHWaw)

Really fun weekend project! 

## Setup
- Just clone the repo and open TFAtWar.xcworkspace, then run the app.
- Uses cocoapods as dependency manager.

### Overall design pattern
- I used MVVM with containers to create and act as the maker of all controllers.
- Each ViewController declares its dependencies in the initialization or, if the VC was created via storyboards, an injection method to inject the requiered parameters.
- The app containers have the responsability to create all dependencies and assemble viewcontrollers.
- I use reactive programming to bind the view model state to the view controller.

### Files map
- [WarEngine]
    - Battlefield: Logic to calculate a winner of 1 battle between 2 players
    - WarEngine: Logic to determine which team won, this class use the Battlefield
    
- [Data]
    - [Repositories]
        - [Persistance]: This folder holds all the logic of persistance for data. It declares a protocol that should be used by any storage engine. Currently UserDefaults is used as storage but we could easily create a core data engine that conforms to the RepositoryProtocol and swap it in the AppDependenciesContainer
        - [Remote]: This folder holds the logic for fetching the remote data. Declares a common protocol that declares what it's needed to be a RemoteRepository. Currently we only have 1 RemoteRepository implementation, the API one, but we could create another one that returns mock data that conforms to the protocol and swap it in the AppDependenciesContainer
        - [Data]: This folder holds the logic for getting the data needed for the app. Declares a common protocol that declares what it's needed to be a DataRepository. It uses a remote and a persistance implementation to fetch data, store it and retrieved it. 
    - [Models]: This folder holds all files that the API need to request, parse or throw an error.
    
- [Common]
    - [View-ViewModels]: This folder holds all view states and view models for the view controllers used in the app. We have a main navigation controller that has the responsability of handling the navigation of the initial flow and the battle field. The initial flow is the list and add VCs
        - [Main]: Holds the view state and view-model of the initial viewcontroller. has the responsability to show the initial flow or battlefield
        - [InitialFlow]: Holds the navigation between the main list and add VCs
        - [Battelfield]: Holds the logic of the battlefield VC with NavigationController
    - We also use navigators and responders to inject the responsability of navigating into multiple view models
    
- [UILayer]
    - [Containers]: This folder holds the dependencies containers that are in charge of creating all dependencies and injecting them into the classes that need them.
    - [Factories]: Example of how we can abstract the factory logic into a class to be reusable
    - [Controllers]: All view controllers with storyboards.
    - [Tools]: Extensions needed to not duplicate code.

## Requirements
- Cocoapods: 1.9.1 or higher
- Should run with any Xcode version that includes at least swift 5.1. It was developed with Xcode 12.2

## Assumptions
- If the battle ends with a tie in the numbers of wins of each team then all players died! 
- We don't validate locally the data to create or edit a transformer.
- You have Xcode installed :P

## Unit Tests
- [x] WarEngine 
- [ ] ViewModels

## Missing things
- Test view models :/ 
- Test UI

