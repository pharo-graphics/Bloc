*Bloc-Utilities - Scrolling
asScrollableElement
	| scrollable |
	self removeFromParent.
	scrollable := BlScrollableElement new.
	scrollable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollable addChild: self.
	^ scrollable