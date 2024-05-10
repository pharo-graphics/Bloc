Extension { #name : #BlElement }

{ #category : #'*Bloc-Infinite' }
BlElement >> asScrollableElement [
	| scrollable |
	self removeFromParent.
	scrollable := self newScrollableParent.
	scrollable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollable addChild: self.
	^ scrollable
]

{ #category : #'*Bloc-Infinite' }
BlElement >> newScrollableParent [

	^ BlScrollableElement new
]
