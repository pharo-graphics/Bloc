running
runOverscrollOn: anOverScroller with: aState
	| aVelocity aVelocityX aVelocityY |
	
	infiniteElement overScrollMode ~= BlOverScrollMode never
		ifTrue: [ infiniteElement considerReleasingGlowsOnScroll: aState dX @ aState dY ].
	
	"Should not overscroll if distances in both directions are zero"
	(aState overscrollX isZero and: [
		aState overscrollY isZero ])
			ifTrue: [ ^ self ].
			
	aVelocity := anOverScroller currentVelocity.
	
	aVelocityX := 0.
	(aState overscrollX ~= aState x)
		ifTrue: [aVelocityX := (aState overscrollX < 0)
			ifTrue: [ aVelocity negated ]
			ifFalse: [ (aState overscrollX > 0)
				ifTrue: [ aVelocity ]
				ifFalse: [ 0 ] ] ].
		
	aVelocityY := 0.
	(aState overscrollY ~= aState y)
		ifTrue: [aVelocityY := (aState overscrollY < 0)
			ifTrue: [ aVelocity negated ]
			ifFalse: [ (aState overscrollY > 0)
				ifTrue: [ aVelocity ]
				ifFalse: [ 0 ] ] ].
	
	"Overscroll happened, make sure glows are notified"
	(infiniteElement overScrollMode ~= BlOverScrollMode never)
		ifTrue: [ infiniteElement absorbGlows: aVelocityX @ aVelocityY ].
	
	"Check if we need to finish scrolling"
	((aVelocityX isZero not or: [
		aState overscrollX = aState x or: [ 
			anOverScroller finalX isZero ] ])
		and: [ aVelocityY isZero not or: [
					aState overscrollY = aState y or: [ 
						anOverScroller finalY isZero ] ] ])

			ifTrue: [ anOverScroller finish ]