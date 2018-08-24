"
I am a match geometry resizer.
I make sure that geometry is always as big as its owner element and resizes together with it
"
Class {
	#name : #BlGeomMatchResizer,
	#superclass : #BlGeometryResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-Support'
}

{ #category : #cleanup }
BlGeomMatchResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlGeomMatchResizer class >> uniqueInstance [
	"Return unique instance of match resizer.
	Note: match resizer is stateless so it is preferable to share
	the same instance for memory and performance reasons"
	<return: #BlGeomMatchResizer>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #resizing }
BlGeomMatchResizer >> adapt: aGeometry to: anElement [
	aGeometry matchElement: anElement
]
