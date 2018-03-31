api - scrolling
fling: aStartPosition velocity: aVelocityPoint min: aMinPosition max: aMaxPosition overshot: anOvershotDistance
	| aVelocityX aVelocityY |

	aVelocityX := aVelocityPoint x.
	aVelocityY := aVelocityPoint y.
	
	"Continue a scroll or fling in progress"
	(isFlywheel and: [ self isFinished not ])
		ifTrue: [
			| anOldVelocityX anOldVelocityY|
			anOldVelocityX := scrollerX currentVelocity.
			anOldVelocityY := scrollerY currentVelocity.
			
			(aVelocityX sign = anOldVelocityX sign and: [ 
				aVelocityY sign = anOldVelocityY sign ])
				ifTrue: [ 
					aVelocityX := aVelocityX + anOldVelocityX.
					aVelocityY := aVelocityY + anOldVelocityY ] ].
	
	mode := Fling.
	
	scrollerX
		fling: aVelocityX
		start: aStartPosition x
		min: aMinPosition x
		max: aMaxPosition x
		over: anOvershotDistance x.

	scrollerY
		fling: aVelocityY
		start: aStartPosition y
		min: aMinPosition y
		max: aMaxPosition y
		over: anOvershotDistance y