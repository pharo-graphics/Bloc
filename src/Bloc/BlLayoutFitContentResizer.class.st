Class {
	#name : #BlLayoutFitContentResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutFitContentResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutFitContentResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutFitContentResizer >> ifFitContent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutFitContentResizer >> isFitContent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementAtMostWith: aNumber [
	"Child wants to determine its own size. It may be bigger than us."

	^ BlMeasurementSpec unspecified
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementExactlyWith: aNumber [
	"Child wants to determine its own size. It may be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementUnspecifiedWith: aNumber [
	"Child wants to determine its own size.... find out how big it should be"
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified: aNumber
]

{ #category : #printing }
BlLayoutFitContentResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content'
]

{ #category : #accessing }
BlLayoutFitContentResizer >> requestedHeightIn: anElement [

	| h |
	anElement hasChildren ifFalse: [ ^ anElement width ].
	h := 0.
	anElement childrenDo: [ :child | h := h + child requestedWidth ].
	^ h
]

{ #category : #accessing }
BlLayoutFitContentResizer >> requestedWidthIn: anElement [

	| w |
	anElement hasChildren ifFalse: [ ^ anElement width ].
	w := 0.
	anElement childrenDo: [ :child |
		w := child constraints horizontal resizer isMatchParent
			     ifTrue: [ w + child measuredWidth ]
			     ifFalse: [ w + child requestedWidth ] ].
	^ w
]
