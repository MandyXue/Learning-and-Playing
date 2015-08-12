#Stanford iOS Class
Just some notes for reviewing and memorizing

#-- Class One --

##What's in iOS (Four Layers)

###Cocoa Touch
* Multi-Touch
* Alerts
* Core Motion
* View Hierachy
* Localization
* Map Kit
* Image Picker
* Controls
* Camera

###Media
* Core Audio
* JPEG/PNG/TIFF
* OpenAL
* PDF
* Audio Mixing
* Quartz(2D)
* Audio Recording
* Core Animation
* Video Playback
* OpenGL ES

###Core Services
* Collections
* Core Location
* Address Book
* Net Services
* Networking
* Threading
* File Access
* Preferences
* SQLite
* URL Utilities

###Core OS
* OSX Kernel
* Power Management
* Mach 3.0
* Keychain Access
* BSD
* Certificates
* Sockets
* File System
* Security
* Bonjour

##Swift
### Advantages
* Concise
* Type Safe
* Type Inference

### Characteristics
* Single Inheritance: only inherit from one class
* All objects, all class, the instances of classes live in the heap; the memory for them is managed for you; Swift use reference counting
* Outlet: instance, variable, property
* Action: method
* let: constant
* var: variable
* 'let' and 'var' improves readability

### Optional
* a strong type
* type inference
* e.g. ```String?```

#### 1. Optional has two kind of values:
##### (1) not set
* nil

##### (2) something
* String, Int, Double, etc. (Here is ```String```)

#### 2. Optional String
* it's not a String that can be nil
* it's an optional that can be a String

#### 3. Unwrap the optional
* use "!"
* e.g. ```let digit = sender.currentTitle!```
* In the example above, if ```sender.currentTitle``` is nil here, when you wrap it, the program will crash.
* But if ```sender.currentTitle``` is String here, digit will be a String.
