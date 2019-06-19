Class {
	#name : #BlLayoutConstraintsAxis,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlLayoutConstraintsAxis >> seamlessDefaultTransferStrategy [ 
	^SeamlessTransferStrategy defaultByValue
]
