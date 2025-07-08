Class {
	#name : #BlElementEffectChangeTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Changes'
}

{ #category : #tests }
BlElementEffectChangeTest >> testShadowOffsetChangesInvalidationBounds [

	| aSpace anElement |
	aSpace := BlSpace new.
	anElement := BlElement new.
	anElement extent: 100 @ 200.
	aSpace root addChild: anElement.

	anElement effect: (BlSimpleShadowEffect
		color: Color red
		offset: 10 @ 20).
	aSpace pulse.
	
	self
		assert: anElement invalidationBounds
		equals: ((0.0 @ 0.0) corner: (110.0 @ 220.0)).
		
	anElement effect: (BlSimpleShadowEffect
		color: Color green
		offset: -10 @ -20).
	aSpace pulse.

	self
		assert: anElement invalidationBounds
		equals: ((-10.0 @ -20.0) corner: (100.0 @ 200.0))
]
