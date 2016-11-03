calculating
size: aContentSize max: aMaxContentSize for: aMeasumentSpec

	aMeasumentSpec isUnspecified
		ifTrue: [ ^ aContentSize ].
		
	aMeasumentSpec isAtMost 
		ifTrue: [ ^ aContentSize min: aMaxContentSize ].
		
	aMeasumentSpec isExact
		ifTrue: [ ^ aMaxContentSize ].
	
	^ aContentSize