Class {
	#name : #BlBackgroundMatchResizer,
	#superclass : #BlBackgroundResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-Support'
}

{ #category : #cleanup }
BlBackgroundMatchResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlBackgroundMatchResizer class >> uniqueInstance [
	"Return unique instance of match resizer.
	Note: match resizer is stateless so it is preferable to share
	the same instance for memory and performance reasons"
	<return: #BlBackgroundMatchResizer>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #resizing }
BlBackgroundMatchResizer >> adapt: aBackground to: anElement [
	aBackground matchExtent: anElement extent
]
