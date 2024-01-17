Extension { #name : 'KeyboardKey' }

{ #category : '*Bloc' }
KeyboardKey >> isShift [ 

	^ self = self class shiftLeft or: [ self = self class shiftRight ]
]

{ #category : '*Bloc' }
KeyboardKey class >> unknown [

	| aKeyboardKey |
	aKeyboardKey := self new.

	^ aKeyboardKey withValue: nil andName: self unknownKeyName
]
