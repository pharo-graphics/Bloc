Extension { #name : #BlElement }

{ #category : #'*Bloc-Utilities - Pannable' }
BlElement >> asPannableElement [
	| pannable |
	self removeFromParent.
	pannable := BlPannableElement new.
	pannable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	pannable contentElement: self.
	^ pannable
]

{ #category : #'*Bloc-Utilities - Pannable' }
BlElement >> asScalableElement [
	| aScalableElement |
	
	self removeFromParent.
	aScalableElement := BlScalableElement new.
	aScalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aScalableElement addChild: self.

	^ aScalableElement
]

{ #category : #'*Bloc-Utilities - Scrolling' }
BlElement >> asScrollableElement [
	| scrollable |
	self removeFromParent.
	scrollable := BlScrollableElement new.
	scrollable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollable addChild: self.
	^ scrollable
]
