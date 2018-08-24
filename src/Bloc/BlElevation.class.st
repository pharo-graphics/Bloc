"
I represent an element elevation given in the same units as width and height.
Elevation allows us to achieve very advanced rendering effects that is not possible with z-index.

Taking elevation into account forces us to have a separate composition rendering tree which is different from an element's structure tree.

Note: Elevation is not influenced by transformation matrix!
"
Class {
	#name : #BlElevation,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'elevation'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : #'instance creation' }
BlElevation class >> elevation: aNumber [
	^ self new elevation: aNumber
]

{ #category : #accessing }
BlElevation >> elevation [
	<return: #Number>

	^ elevation
]

{ #category : #accessing }
BlElevation >> elevation: aNumber [
	self
		assert: [ elevation isNil ]
		description: [ 'I am immutable and can not be changed' ].

	elevation := aNumber
]

{ #category : #accessing }
BlElevation >> relatedTo: aNumber [
	"Compute and return a resulting elevation related to the elevation represented as a number"
	<return: #Number>
	
	^ self subclassResponsibility
]
