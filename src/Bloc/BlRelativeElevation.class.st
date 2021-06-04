"
I am the most commonly used elevation given in relative to the parent. It allows us to construct independent complex reusable visual components with support of inner elevation (a pyramid of elements).

Note: Relative elevation can be negative!

"
Class {
	#name : #BlRelativeElevation,
	#superclass : #BlElevation,
	#classInstVars : [
		'zero'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #cleanup }
BlRelativeElevation class >> cleanUp [
	super cleanUp.
	
	zero := nil
]

{ #category : #'instance creation' }
BlRelativeElevation class >> zero [
	<return: #BlGlobalElevation>

	^ zero ifNil: [ zero := self elevation: 0 ]
]

{ #category : #accessing }
BlRelativeElevation >> relatedTo: aNumber [
	"Resulting elevation is a sum of a given and my relative one"
	<return: #Number>

	^ aNumber + self elevation
]
