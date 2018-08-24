Class {
	#name : #BlGridAlignmentMode,
	#superclass : #Object,
	#classVars : [
		'ALIGN_BOUNDS',
		'ALIGN_MARGINS'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #'alignment modes' }
BlGridAlignmentMode class >> alignBounds [
	^ ALIGN_BOUNDS
]

{ #category : #'alignment modes' }
BlGridAlignmentMode class >> alignMargins [
	^ ALIGN_MARGINS
]

{ #category : #'class initialization' }
BlGridAlignmentMode class >> initialize [
	super initialize.
	
	ALIGN_MARGINS := BlGridAlignMarginsMode new.
	ALIGN_BOUNDS := BlGridAlignBoundsMode new
]

{ #category : #comparing }
BlGridAlignmentMode >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #testing }
BlGridAlignmentMode >> isAlignBounds [
	^ false
]

{ #category : #testing }
BlGridAlignmentMode >> isAlignMargins [
	^ false
]

{ #category : #'computing margins' }
BlGridAlignmentMode >> marginOf: anChildElement in: aGridLayout isHorizontal: isHorizontal isLeading: isLeading [
	^ self subclassResponsibility
]
