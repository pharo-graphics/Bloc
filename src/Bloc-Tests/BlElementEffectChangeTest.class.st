Class {
	#name : #BlElementEffectChangeTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Changes'
}

{ #category : #tests }
BlElementEffectChangeTest >> testShadowOffsetChangesInvalidationBounds [

	| aSpace anElement |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	anElement := BlElement new.
	anElement extent: 100 @ 200.
	[
		aSpace show; waitPendingWork.
		aSpace mutateSync: [ aSpace root addChild: anElement ].

		aSpace mutateSync: [
			anElement effect: (BlSimpleShadowEffect
				color: Color red
				offset: 10 @ 20) ].

		self
			assert: anElement invalidationBounds
			equals: ((0.0 @ 0.0) corner: (110.0 @ 220.0)).

		aSpace mutateSync: [
			anElement effect: (BlSimpleShadowEffect
				color: Color green
				offset: -10 @ -20) ].

		self
			assert: anElement invalidationBounds
			equals: ((-10.0 @ -20.0) corner: (100.0 @ 200.0))
	] ensure: [
		aSpace close; waitPendingWork ]
]
