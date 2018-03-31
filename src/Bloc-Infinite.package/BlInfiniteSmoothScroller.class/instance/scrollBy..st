scrolling
scrollBy: aPoint
	| anItemCount |
	
	anItemCount := infiniteElement state itemCount.
	
	"If there are no items in datasource but smooth scroll is running, we need to stop it"
	anItemCount isZero
		ifTrue: [ ^ self stop ].
		
	self targetPosition > anItemCount
		"requested target position is greater that item count, scroll to the last item instead"
		ifTrue: [ self targetPosition: anItemCount ].


	self onScrollBy: aPoint