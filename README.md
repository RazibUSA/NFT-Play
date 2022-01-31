# NFT-Play
NFT-Play is an iPhone based project using SwiftUI, MVVM-C, Combine, NFT, OpenSea,etc. This project is a structural project to work and further learning in the state of the art iOS ecosystem.

## Major Topics in this project:

- MVVM with SwiftUI 
- Combine framework.
- Custom UI using ViewBuilder
- Networking with Combine framework using Open Sea API.
- Unit test: Mock network data, view model test, dependency injection, etc.
- Structure of a SwiftUI project- TBD.

## Compatibility

- Xcode 13.2.1 & MacOS Monterey
- iOS 14 and later
- SwiftUI 3 and later
- Swift 5 and later

## MVVM with SwiftUI
MVVM in IOS is somewhat different from MVC in iOS. 

User -> View -> ViewController -> ViewModel -> Model

The ViewModel will send the data request from the server and will add data to the Model. It will process the overall calculations for conversion and pass back the value to the ViewController which in turn will update the View.

The Key takeaway: In MVVM, you have a new ViewModel class which interacts with Model. This means that Controller is no longer responsible for the same. Therefore, the Controller will only do what is supposed to do i.e working with Views. It does not know about the existence of the Model.

Having ViewModel as the mediator also brings out two biggest benefits in terms of development and testing such as:

First: ViewModel forms a one-way communication with View due to its binding with View. This way, View will hold the reference to its ViewModel. However, ViewModel is restricted from knowing about its View. Therefore, It can be used by many View objects.
Second: ViewModel has the ability to observe changes in Model and synchronization with events. Due to the existence of binding between View and ViewModel, Former can be updated accordingly. This brings the most out from the app in the form of responsive experience for users.
Since ViewModel is an independent layer which knows nothing about Model, it is very easy to unit test.
