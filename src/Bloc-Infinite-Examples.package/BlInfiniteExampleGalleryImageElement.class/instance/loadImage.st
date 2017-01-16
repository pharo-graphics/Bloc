accessing
loadImage
	| anImage aForm |
	
	loader ifNotNil: #terminate.
	anImage := image.
	aForm := form.
	
	(anImage form isNotNil and: [ anImage form extent = self extent asIntegerPoint ])
		ifTrue: [
			aForm = anImage form
				ifFalse: [ self form: anImage form ].
			^ self ].

	loader := [
		| aNewForm timesRetry aByteArray |
		timesRetry := 0.
		[ (aByteArray := (image loadUrl: self extent asIntegerPoint) asUrl retrieveContents) isNil and: [ 
			timesRetry < 5 ] ] whileTrue: [ timesRetry := timesRetry + 1 ].
		aByteArray ifNotNil: [
			aNewForm := Form fromBinaryStream: aByteArray readStream.
			anImage form: aNewForm.
			image = anImage
				ifTrue: [
					BlUniverse default animationManager
						addAnimation: (BlInfinitePostAction on: [ self form: aNewForm ]) ] ] ] fork