Extension { #name : #BlElement }

{ #category : #'*Bloc-Scalable' }
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
