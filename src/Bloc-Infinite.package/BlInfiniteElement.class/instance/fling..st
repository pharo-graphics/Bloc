scrolling
fling: aVelocity
	| aVelocityX aVelocityY canScrollHorizontal canScrollVertical |
	
	layoutFrozen
		ifTrue: [ ^ false ].
	
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	aVelocityX := aVelocity x.
	aVelocityY := aVelocity y.
	
	(canScrollHorizontal not or: [ aVelocityX abs < self minFlingVelocity ])
		ifTrue: [ aVelocityX := 0 ].
	
	(canScrollVertical not or: [ aVelocityY abs < self minFlingVelocity ])
		ifTrue: [ aVelocityY := 0 ].
	
	"If we don't have any velocity, return false"
	(aVelocityX isZero and: [ aVelocityY isZero ])
		ifTrue: [ ^ false ].
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			aVelocityX := self maxFlingVelocity negated max: (aVelocityX min: self maxFlingVelocity).
			aVelocityY := self maxFlingVelocity negated max: (aVelocityY min: self maxFlingVelocity).
			scrollFlinger flingBy: aVelocityX @ aVelocityY.
			^ true ].
	^ false