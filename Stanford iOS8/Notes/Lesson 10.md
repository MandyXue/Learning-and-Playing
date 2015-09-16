#-- Class Ten --

### UITextField

* editable, like UILabel

* first responder
```swift
becomeFirstResponder()
resignFirstResponder()
```

* delegate
```swift
func textFieldShouldReturn(sender: UITextField)
```

* other properties
```swift
var clearsOnBeginEditing: Bool
var adjustsFontSizeToFitWidth: Bool
var minimumFontSize: CGFloat    // always set this if you set adjustsFontSizeToFitWidth
var placeholder: String         // drawn in gray when text field is empty
var background/disabledBackground: UIImage
var defaultTextAttributes: Dictionary  // applies to entire text
```

* **left** and **right** overlays

====

### Keyboard

##### Set the properties defined in the UITextInputTraits protocol (which UITextField implements):
```swift
varUITextAutocapitalizationTypeautocapitalizationType //words,sentences,etc.
var UITextAutocorrectionType autocorrectionType       // yes or no
var UIReturnKeyType returnKeyType                     // Go, Search, Google, Done, etc.
var BOOL secureTextEntry                              // for passwords, for example
var UIKeyboardType keyboardType                       // ASCII, URL, PhonePad, etc.
```

##### The keyboard comes up over other views
```swift
NSNotificationCenter.defaultCenter().addObserver( self,
										selector: "theKeyboardAppeared:",
											name: UIKeyboardDidShowNotification,
										  object: view.window)
```

====

### UITableView

##### Features
* subclass of UIScrollView
* static/dynamic
* customization: dataSource protocol and delegate protocol
* efficient with very large sets of data

##### Style
* plain (header, cell, footer)
* grouped (sections or not)

##### Cell Type
* subtitle
* basic
* right/left detail

##### Protocols
* **delegate**: to control how the table is displayed
* **dataSource**: provides data that is displayed inside the cells

##### Customizing Each Row

```swift
func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
	let data = myInternalDataStructure[indexPath.section][indexPath.row]
	let dequeued: AnyObject = tv.dequeueReusableCellWithIdentifier(“MyCell”, forIndexPath: indexPath)
	let cell = dequeued as UITableViewCell  // create a UITableViewCell and load it up with data
	cell.textLabel?.text = “Title”
    cell.detailTextLabel?.text = “Subtitle”
	return cell
}
```
====

### Demo

* UIRefreshControl
* When the ```Lines``` of ```TextField``` is ```0```, it will use as many lines as it needs.