"
I represent a global element elevation given in Space coordinate system.

"
Class {
	#name : #BlGlobalElevation,
	#superclass : #BlElevation,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlGlobalElevation >> relatedTo: aNumber [
	"Global elevation is constant"

	^ elevation
]
