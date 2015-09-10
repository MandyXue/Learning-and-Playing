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

* create as needed

##### How to create: (usually not necessary)

* executing a func on another queue:
```swift
let queue: dispatch_queue_t = dispatch_async(queue) { /* do what you want to */ }
```

* the main queue:
```swift
let mainQ: dispatch_queue_t = dispatch_get_main_queue()
let mainQ: NSOperationQueue = NSOperationQueue.mainQueue() // for object-oriented APIs
// All UI stuff must be done on this queue!
dispatch_async(notTheMainQueue) {
	// do time-consuming things
	dispatch_async(dispatch_get_main_queue()) {
		// tell main queue to update UI
	}
}
```
* other queues:
```swift
QOS_CLASS_USER_INTERACTIVE //quickandhighpriority
QOS_CLASS_USER_INITIATED   // high priority, might take time
QOS_CLASS_UTILITY          // long running
QOS_CLASS_BACKGROUND       // user not concerned things (prefetching, database, etc.)
let qos = Int(<one of the above>.value) // ugh, historical reasons
let queue = dispatch_get_global_queue(qos, 0)
```

* create your own serial quque:
```swift
let serialQ = dispatch_queue_create(“name”, DISPATCH_QUEUE_SERIAL)
```

##### Multithreaded iOS API
e.g.
```swift
let session = NSURLSession(NSURLSessionConfiguration.defaultSessionConfiguration())
if let url = NSURL(string: “http://url”) {
	let request = NSURLRequest(URL: url)
	let task = session.downloadTaskWithRequest(request) { (localURL, response, error) in
		dispatch_async(dispatch_get_main_queue()) {
			/* I want to do something in the UI here, can I? */
		}
	}
	task.resume()
}

```

=====

### Demo:

* activity indicator view