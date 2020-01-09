Class {
	#name : #BlSpartaSpaceRenderer,
	#superclass : #BlHostSpaceRenderer,
	#instVars : [
		'spartaCanvas',
		'session',
		'physicalSize',
		'scaleFactor'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #rendering }
BlSpartaSpaceRenderer >> damagedAreasOf: aSpace [
	^ aSpace dirtyAreas
]

{ #category : #initialization }
BlSpartaSpaceRenderer >> initializeCanvas: aSpartaCanvas surface: aSurface [
	spartaCanvas := aSpartaCanvas.
	physicalSize := aSurface physicalSize.
	scaleFactor := aSurface scaleFactor.
	session := Smalltalk session
]

{ #category : #testing }
BlSpartaSpaceRenderer >> isValid [
	<return: #Boolean>
	
	^ session == Smalltalk session
		and: [ spartaCanvas isNotNil
			and: [ spartaCanvas isValid ] ]
]

{ #category : #accessing }
BlSpartaSpaceRenderer >> physicalSize [
	<return: #GtFensterPhysicalSize>

	^ physicalSize
]

{ #category : #rendering }
BlSpartaSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	| theDirtyAreas aLogicalExtent |
	
	self isValid
		ifFalse: [ ^ self ].
	
	aLogicalExtent := (physicalSize asLogical: self scaleFactor) asPoint.
	
	"collect the dirty area to be updated"
	theDirtyAreas := (self damagedAreasOf: aSpace)
		collect: [ :each | each intersect: (0@0 extent: aLogicalExtent) ifNone: [ nil ] ]
		thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	spartaCanvas transform
		by: [ :t | t scaleBy: scaleFactor asPoint ]
		during: [
			theDirtyAreas do: [ :aBlBounds |
				spartaCanvas clip by: aBlBounds during: [ aSpace fullDrawOn: spartaCanvas ] ] ].

	spartaCanvas flush.
	
	^ theDirtyAreas
]

{ #category : #accessing }
BlSpartaSpaceRenderer >> scaleFactor [
	<return: #Number>

	^ scaleFactor
]
