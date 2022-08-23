Extension { #name : #KeyboardKey }

{ #category : #'*Bloc' }
KeyboardKey >> isShift [ 

	^ self = self class shiftLeft or: [ self = self class shiftRight ]
]
