#-- Class Seven --

### Segues

* show segue
* show detail segue: in split view, show this MVC as the detail
* modal
* popover segue

##### segues always create new MVCs

### Preparing for a Segue

```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var destination = segue.destinationViewController as? UIViewController
    if let navCon = destination as? UINavigationController {
        destination = navCon.visibleViewController
    }
    if let hvc = destination as? HappinessViewController {
        if let identifier = segue.identifier {
            switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
            }
        }
    }
}
```

* It is crucial to understand that this preparation is happening **BEFORE** outlets get set!

### Popover

* not a UIViewController, but a PresentaionController

##### prepare for segue:

```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
        switch identifier {
        case History.SegueIdentifier:
            if let tvc = segue.destinationViewController as? TextViewController {
                //prevent the iPhone adaptation behavior
                if let ppc = tvc.popoverPresentationController {
                    ppc.delegate = self
                }
                tvc.text = "\(diagnosticHistory)"
            }
        default: break
        }
    }
}
```
##### preferredContentSize:

```swift
//fix the size of the popover view
override var preferredContentSize: CGSize {
    get {
        if textView != nil && presentingViewController != nil {
            return textView.sizeThatFits(presentingViewController!.view.bounds.size)
        } else {
            return super.preferredContentSize
        }
    }
    set {
        super.preferredContentSize = newValue
    }
}
```