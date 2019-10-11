Class {
	#name : #BlSpartaCanvasPainter,
	#superclass : #BlHostCanvasPainter,
	#instVars : [
		'spartaCanvas',
		'session',
		'dpiFactor',
		'physicalSize'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #accessing }
BlSpartaCanvasPainter >> dpiFactor [
	<return: #Number>

	^ dpiFactor
]

{ #category : #initialization }
BlSpartaCanvasPainter >> initializeWithCanvas: aSpartaCanvas surface: aSurface [
	spartaCanvas := aSpartaCanvas.
	physicalSize := aSurface physicalSize.
	dpiFactor := aSurface dpiFactor.
	session := Smalltalk session
]

{ #category : #testing }
BlSpartaCanvasPainter >> isValid [
	<return: #Boolean>
	
	^ session == Smalltalk session
		and: [ spartaCanvas isNotNil
			and: [ spartaCanvas isValid ] ]
]

{ #category : #accessing }
BlSpartaCanvasPainter >> physicalSize [
	<return: #BlHostPhysicalSize>

	^ physicalSize
]

{ #category : #rendering }
BlSpartaCanvasPainter >> render: aSpace dirtyAreas: aCollectionOfRectangles [
	<return: #Collection of: #Rectangle>
	| theDirtyAreas aLogicalExtent |
	
	self isValid
		ifFalse: [ ^ self ].
	
	aLogicalExtent := (physicalSize asLogical: self dpiFactor) asPoint.
	
	"collect the dirty area to be updated"
	theDirtyAreas := aCollectionOfRectangles 
		collect: [ :each | each intersect: (0@0 extent: aLogicalExtent) ifNone: [ nil ] ]
		thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	spartaCanvas transform
		by: [ :t | t scaleBy: dpiFactor asPoint ]
		during: [
			theDirtyAreas do: [ :aBlBounds |
				spartaCanvas clip by: aBlBounds during: [ aSpace fullDrawOn: spartaCanvas ] ] ].

	spartaCanvas flush.
	
	^ theDirtyAreas
]
