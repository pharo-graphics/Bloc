scrolling
fling: aStartPoint velocity: aVelocityPoint min: aMinPoint max: aMaxPoint overshot: anOvershotDistancePoint
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
	scrollerX flingFor: aVelocityX start: aStartPoint x min: aMinPoint x max: aMaxPoint x over: anOvershotDistancePoint x.
	scrollerY flingFor: aVelocityY start: aStartPoint y min: aMinPoint y max: aMaxPoint y over: anOvershotDistancePoint y