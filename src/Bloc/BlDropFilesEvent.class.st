Class {
	#name : #BlDropFilesEvent,
	#superclass : #Object,
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlDropFilesEvent >> seamlessDefaultTransferStrategy [ 
	^SeamlessTransferStrategy defaultByValue
]
