#-- Class Twelve --

### Dynamic Animation

1. steps
	1. create a ```UIDynamicAnimator```
		```swift
		var animator = UIDynamicAnimator(referenceView: UIView)
		```
	2. add ```UIDynamicAnimator```s to it(gravity, collisions, etc)
		```swift
		let gravity = UIGravityBehavior()
		animator.addBehavior(gravity)
		```
	3. add ```UIDynamicItem```s (usually UIViews) to the ```UIDynamicBehavior```s
		(```UIDynamicItem``` is an protocol which UIView happens to implement)
		```swift
		let item: UIDynamicItem = ...//usually a UIView
		gravity.addItem(item)
		```
	4. ```UIDynamicItem``` protocol
		```swift
		protocol UIDynamicItem {
			var bounds: CGRect { get }
			var center: CGPoint { get set }
			var transform: CGAffineTransform { get set }
		}
		```

2. Behaviors
	1. UIGravityBehavior
		```swift
		var angle: CGFloat
		var magnitude: CGFloat
		```
	2. UIAttachmentBehavior
		* attach to item
		* attach to anchor
	3. UICollisionBehavior
		```swift
		var collisionMode: UICollisionBehaviorMode
		```
	4. UISnapBehavior
	5. UIPushBehavior
	6. UIDynamicItemBehavior
		how much springing it is
	7. UIDynamicBehavior
		superclass of behaviors
	8. UIDynamicBehavior's action property
		```swift
		var action: (() -> Void)?
		```
		will be executed every time this behavior acts upon its items
	9. UIDynamicBehavior's delegate