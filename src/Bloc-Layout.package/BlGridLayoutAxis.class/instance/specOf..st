accessing spec
specOf: anElement
	^ self horizontal
			ifTrue: [ anElement constraints horizontal spec ]
			ifFalse: [ anElement constraints vertical spec ]