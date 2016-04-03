#-- Class Eight --

### Life Cycle

1. preparation
2. outlet setting
3. appearing and disappearing
4. geometry changes
5. low-memory situations

#### After init and outlet-setting
viewDidLoad:
```swift
override func viewDidLoad() {
    super.viewDidLoad() // always let super have a chance in lifecycle methods
    // do some setup of my MVC
}
```

* a great place to update UI
* only load once

**Do not init things that are geometry-dependent here!**

#### Before appear
viewWillAppear:
```swift
func viewWillAppear(animated: BOOL)
// animated is whether you are appearing over time
```

* ```view.bound``` is set
* get things from the network
* set geometry

viewDidAppear: ("did" version)
```swift
func viewDidAppear(animated: BOOL)
```

#### Before disappearing
```swift
override func viewWillDisappear(animated: BOOL) {
    super.viewWillDisappear(animated) // call super
    // do some clean up
    // be careful not to do anything time-consuming
    // maybe even kick off a thread to do stuff here
}
```
viewDidDisappear: ("did" version)

#### Geometry changed
```swift
func viewWillLayoutSubviews()
func viewDidLayoutSubviews()
```

* called any time a view's **frame** changed and its **subviews** were thus re-layed out
* reset frames of subviews here / set other geometry-related properties
* between ```will``` and ```did```, autolayout will happen

#### Autorotation

if you want to participate in the rotation animation, you can use this method:
```swift
func viewWillTransitionToSize(
    size: CGSize,
    withTransitionCoordinator: UIViewControllerTransitionCoordinator
)
```

#### Low Memory Situations
didReceiveMemoryWarning

#### awakeFromNib

* sent to all objs that come out of a storyboard
* happens **before** outlets are set!
* **put code somewhere else** if at all possible

e.g. set yourself as the delegate of the split view controller you're in.

=====

### Autolayout

Already learned:
* dashed blue lines
* Ctrl-dragging: create relationships
* "pin" and "arrange" popovers
* reset to suggested constraints
* document outline
* size inspector

In Demo:
* Content Compression Ressistance Priority
* Click on the constraint => Alignment Constraint (on the right): Constant, Multiplier, etc.
* Content Hugging Priority