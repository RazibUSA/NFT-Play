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

## Combine
### When to use Combine, and how does it work?

Reactive programming is mainly used to handle asynchronous datastreams inside your app, such as API calls. It can also be used if your UI has to wait for some action to happen, before being updated.

The way it works is described as a dataflow pipeline. There are three elements involved in this pipeline: 

- publishers, 
- operators 
- subscribers.
 
The subscriber asks the publisher for some data, which sends it through an operator before it ends up at the subscriber who requested it.

### Publishers

Simply, the publisher provides the data and an error if necessary. The data will be delivered as an object defined by us, and we can also handle custom errors. There are 2 types of publishers:
- Just: initialised from a value that only provides a single result (no error)
- Future: initialised with a closure that eventually resolves to a single output value or a failure completion

Subjects are a special kind of publisher, that is used to send specific values to one or multiple subscribers at the same time. There are two types of built-in subjects with Combine; CurrentValueSubject & PassthroughSubject. They act similarly, the difference being currentValueSubject remembers and requires an initial state, where passthroughSubject does not.

### Subscribers

The subscriber asks the publisher for data. It’s able to cancel the request if needed, which terminates a subscription and shuts down all the stream processing prior to any Completion sent by the publisher. There are two types of subscribers build into Combine:
- Assign:.assign assigns values to objects, like assigning a string to a labels text property directly.  
- Sink: .sink defines a closure, that accepts the value from the publisher when it’s read.

### Operators

An operator is a middle ground between the publisher and the subscriber, and because of this, it acts as both. When a publisher talks to the operator, it’s acting as a subscriber, and when the subscriber talks to the operator, it’s acting as a publisher. The operators are used to change the data inside the pipeline. That could be if we want to filter out nil-values, change a timestamp etc. before returning. Operator is actually just a convenience name for higher order functions that you probably already know, such as .map , .filter, .reduce etc.




