accessing spec
specOf: anElement
	^ self horizontal
		ifTrue: [ anElement constraints grid horizontal spec ]
		ifFalse: [ anElement constraints grid vertical spec ]