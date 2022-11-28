Extension { #name : #BlBorder }

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyTo: aeCanvas element: anElement [
	
	self isTransparent
		ifTrue: [ aeCanvas setBorderOff ]
		ifFalse: [
			anElement outskirts aeApplyTo: aeCanvas.
			aeCanvas setBorderBlock: [
				self paint aeApplyTo: aeCanvas.
				self style aeApplyTo: aeCanvas.
				aeCanvas setBorderWidth: self width ] ].
]
