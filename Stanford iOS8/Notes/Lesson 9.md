#-- Class Nine --

### Scroll View

##### Adding subviews to a UIScrollView:
```swift
// First, tell the scroll view how big the area you want to scroll over is.
// the property is contentSize
scrollView.contentSize = CGSize(width: 3000, height: 2000)
logo.frame = CGRect(x:..,y:..,width:..,height:...)
scrollView.addSubview(logo)
```

##### Where is it positioned?
```swift
let upperLeftOfVisible: CGPoint = scrollView.contentOffset
```

##### Bounds: actual rectangle which is shown now
```swift
let visibleRect: CGRect = aerial.convertRect(scrollView.bounds, fromView: scrollView)
```

##### Create a ScrollView?

* storyboard
* select a UIView => Embed in => Scroll View
* in code

##### Scrolling programmatically
```swift
func scrollRectToVisible(CGRect, animated: Bool)
```

##### Zooming
Set max/min zoom scale:
```swift
scrollView.minimumZoomScale = 0.5  // 0.5 means half its normal size
scrollView.maximumZoomScale = 2.0
```

Delegate:
```swift
func viewForZoomingInScrollView(sender: UIScrollView) -> UIView
```

Zooming Programatically:
```swift
var zoomScale: CGFloat
func getZoomScale(CGFloat, animated: Bool)
func zoomToRect(CGRect, animated: Bool)
```

=====

### Closures

##### Capturing
##### sometimes better than delegation
```swift
class Grapher {
	var yForX: ((x: Double) -> Double?)? // completely and utterly generic 
}
let grapher = Grapher()
let graphingBrain = CalculatorBrain()
graphingBrain.program = theProgramToGraph

grapher.yForX = { (x: Double) -> Double? in
    graphingBrain.variableValues[“M”] = x
	return graphingBrain.evaluate() // gets captured and reused each time yForX is called
}
```

##### Capture Danger

create a memory cycle:
a captured pointer points back at the closure

=====

### Multithreading

##### Queues

* functions are lined up in a queue
* then those functions are pulled off the queue and executed on an associated thread.

##### Main Queue

* serial, one at a time
* all UI activity has to happen on the main queue

##### Other queues

##### 