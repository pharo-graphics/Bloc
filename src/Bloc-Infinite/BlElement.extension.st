Extension { #name : #BlElement }

{ #category : #'*Bloc-Infinite' }
BlElement >> asScrollableElement [
	| scrollableParent |
	self removeFromParent.
	scrollableParent := self newScrollable.
	scrollableParent constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollableParent addChild: self.
	^ scrollableParent
]

{ #category : #'*Bloc-Infinite' }
BlElement >> newScrollable [

	^ BlScrollableElement new
]
