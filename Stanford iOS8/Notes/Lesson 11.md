#-- Class Eleven --

### Unwind Segue

1. the only segue not create a new MVC
2. good to jump back in a navigation controller
3. dismiss a modally segued-to MVC
4. how to work?
	1. (method:)```@IBAction``` + (argument:)```UIStoryboardSegue```
	2. ctrl + drag -> exit
	3. prepareForSegue

====

### Alerts and Action Sheets

1. Action Sheet
	```swift
	var alert = UIAlertController(
		title: "Redeploy Cassini",
		message: "Issue commands to Cassini's guidance system.",
		preferredStyle: UIAlertControllerStyle.ActionSheet
	)
	//API
	alert.addAction(UIAlertAction(
		title: String,
		style: UIAlertActionStyle,
		handler: (action: UIAlertAction) -> Void
	))
	//Example1:
	//orbit saturn action
	alert.addAction(UIAlertAction(
		title: "Orbit Saturn",
		style: UIAlertActionStyle.Default)
		{ (action: UIAlertAction) -> Void in
			// go into orbit around Saturn
		}
	))
	//Example2:
	//explore titan action
	alert.addAction(UIAlertAction(
		title: "Explore Titan",
		style: .Default)
		{ (action: UIAlertAction) -> Void in
			if !self.loggedIn { self.login() }
			// if loggedIn go to titan
		}
	))
	//Example3:
	//closeup of sun action
	alert.addAction(UIAlertAction(
		title: "Closeup of Sun",
		style: .Destructive)  //show up in red
		{ (action: UIAlertAction) -> Void in
			if !self.loggedIn { self.login() }
			// if loggedIn destroy Cassini by going to Sun
		}
	))
	//Example4:
	//cancel action
	alert.addAction(UIAlertAction(
		title: "Cancel",
		style: .Cancel)  //show up in red
		{ (action: UIAlertAction) -> Void in
			// do nothing
		}
	))
	//present
	presentViewController(alert, animated: true, completion: nil)
	```

	* will be shown as popover in iPad, and don't need a cancel button
	* and the following work will not influence style on the phone
	```swift
	alert.addAction(...)

	alert.modalPresentationStyle = .Popover
	let ppc = alert.popoverPresentationController
	ppc?.barButtonItem = redeployBarButtonItem

	presentViewController(...)
	```

2. Alert:
	```swift
	var alert = UIAlertController(
		title: "...",
		message: "...",
		preferredStyle: UIAlertControllerStyle.Alert
	)
	//the same in add action
	alert.addAction(/* cancel button action */)
	//login action
	alert.addAction(UIAlertAction(
		title: "Login",
		style: .Default)  //show up in red
		{ (action: UIAlertAction) -> Void in
			let tf = self.alert.textFields?.first as? UITextField
			if tf != nil {
				self.loginWithPassword(tf.text)
			}
		}
	))
	alert.addTextFieldWithConfigurationHandler { (textField) in
		textField.placeholder = "..."
	}
	```

====

### NSTimer

* main queue
* cannot run in real time
* complement on animation
* ```methodName:``` means a method with argument
* tolerance is in seconds: ```timer.tolerance = 10```

====

### Animation

1. Kinds
	1. UIView properties
	2. View Controller transitions
	3. Core Animation
	4. Dynamic Animation (physics based animation)

2. UIView Animation
	1. properties:
		* frame
		* transform(translation, rotation and scale)
		* alpha(opacity)
	2. example:
		```swift
		if myView.alpha = 1.0 {
			UIView.animateWithDuration(3.0
								delay: 2.0
							  options: UIViewAnimationOptions.CurveEaseInEaseOut)
						   animations: { myView.alpha = 0.0 }
						   completion: { if $0 { myView.removeFromSuperview() } }
			println("myView.alpha = \(myView.alpha)")
		}
		```
	3. options
	4. change entire view
		* ```UIView.transitionWithView(...)```
	5. change view hierarchy
		* ```UIView.transitionFromView(...)```