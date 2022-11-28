"
I represent a global element elevation given in Space coordinate system.

"
Class {
	#name : #BlGlobalElevation,
	#superclass : #BlElevation,
	#classInstVars : [
		'zero'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #cleanup }
BlGlobalElevation class >> cleanUp [
	super cleanUp.
	
	zero := nil
]

{ #category : #'instance creation' }
BlGlobalElevation class >> zero [

	^ zero ifNil: [ zero := self elevation: 0 ]
]

{ #category : #accessing }
BlGlobalElevation >> relatedTo: aNumber [
	"Global elevation is constant"
	<return: #Number>

	^ self elevation
]
