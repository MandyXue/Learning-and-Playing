#-- Class Six --

### Extensions

* can't re-implement methods or properties that are already there
* the properties you add can have no storage associated with them

=====

### Delegate

protocols:

* a way to express an API
* a type with no implementation, only declaration

Three aspects:

1. the protocol declaration
2. the declaration where a class, struct or enum says that it implements a protocol
3. the actual implementation of the protocol in said class, struct or enum

Delegations:

1. create a delegation protocol
2. create a delegate property in the view whose type is that delegation protocol
3. use the delegate property to get/do things it can't own or control
4. controller declares that it implements the protocol
5. controller sets self as the delegation
6. implement the protocol in controller

=====

### Gestures

##### Two sides

1. add a gesture recognizer to a UIView

```swift
@IBOutlet weak var pannableView: UIView {
    didSet {
        let recognizer = UIPanGestureRecognizer(target: self, action: “pan:”)
        pannableView.addGestureRecognizer(recognizer)
    }
}
```
2. providing a method to handle that gesture

```swift
func pan(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
        case .Changed: fallthrough
        case .Ended:
            let translation = gesture.translationInView(pannableView)
            // update anything that depends on the pan gesture using translation.x and .y
            gesture.setTranslation(CGPointZero, inView: pannableView)
        default: break
    }
}
```

##### Other Gestures

* UIPinchGestureRecognizer

```swift
var scale: CGFloat // not read-only (can reset)
var velocity: CGFloat { get } // scale factor per second
```

* UIRotationGestureRecognizer

```swift
var rotation: CGFloat // not read-only (can reset); in radians
var velocity: CGFloat { get } // radians per second
```

* UISwipeGestureRecognizer

```swift
//Set up the direction and number of fingers you want, then look for .Recognized
var direction: UISwipeGestureRecoginzerDirection // which swipes you want
var numberOfTouchesRequired: Int // finger count
```

* UITapGestureRecognizer

```swift
//Set up the number of taps and fingers you want, then look for .Ended
var numberOfTapsRequired: Int // single tap, double tap, etc.
var numberOfTouchesRequired: Int // finger count
```

=====

### Multiply MVC

* UITabBarController
* UISplitViewController
* UINavigationController