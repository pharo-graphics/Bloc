"
I am a relative transformation origin which is attached to the center of an element.

"
Class {
	#name : #BlAffineTransformationCenterOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#classInstVars : [
		'defaultInstance'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'accessing' }
BlAffineTransformationCenterOrigin class >> defaultInstance [

	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : 'math' }
BlAffineTransformationCenterOrigin >> originIn: anElement [

	^ anElement extent / 2.0
]
