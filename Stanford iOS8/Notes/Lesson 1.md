#-- Class One --

##What's in iOS (Four Layers)

| Cocoa Touch     | Media             | Core Services    | Core OS           |
| --------------- | ----------------- | ---------------- | ----------------- |
| Multi-Touch     | Core Audio        | Collections      | OSX Kernel        |
| Alerts          | JPEG/PNG/TIFF     | Core Location    | Power Management  |
| Core Motion     | OpenAL            | Address Book     | Mach 3.0          |
| View Hierachy   | PDF               | Net Services     | Keychain Access   |
| Localization    | Audio Mixing      | Networking       | BSD               |
| Map Kit         | Quartz(2D)        | Threading        | Certificates      |
| Image Picker    | Audio Recording   | File Access      | Sockets           |
| Controls        | Core Animation    | Preferences      | File System       |
| Camera          | Video Playback    | SQLite           | Security          |
|                 | OpenGL ES         | URL Utilities    | Bonjour           |

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
* e.g. 
```swift
let digit = sender.currentTitle!
```
* In the example above, if ```sender.currentTitle``` is nil here, when you wrap it, the program will crash.
* But if ```sender.currentTitle``` is String here, digit will be a String.