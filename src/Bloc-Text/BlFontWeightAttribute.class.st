"
I represent a font weight attribute.
I am used together with `BlText` and `BlTextStyler` to style text.

Public API and Key Messages

- weight: set font weight in absolute units (100, 200, 400, 600, 800)

Example:

	BlFontWeightAttribute weight: 400.
	BlFontWeightAttribute bold.
	BlFontWeightAttribute normal.
	BlFontWeightAttribute thin
 
Internal Representation and Key Implementation Points.

    Instance Variables
	weight		<Number> 

"
Class {
	#name : #BlFontWeightAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'weight'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlFontWeightAttribute class >> black [
	^ self new
		weight: LogicalFont weightBlack;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> bold [
	^ self new
		weight: LogicalFont weightBold;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> light [
	^ self new
		weight: LogicalFont weightLight;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> medium [
	^ self new
		weight: LogicalFont weightMedium;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> normal [
	^ self new
		weight: LogicalFont weightRegular;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> thin [
	^ self new
		weight: LogicalFont weightThin;
		yourself
]

{ #category : #'instance creation' }
BlFontWeightAttribute class >> weight: aNumber [
	^ self new
		weight: aNumber;
		yourself
]

{ #category : #'text style' }
BlFontWeightAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder fontWeight: self weight
]

{ #category : #comparing }
BlFontWeightAttribute >> equals: anAnotherAttribute [
	^ self weight = anAnotherAttribute weight
]

{ #category : #comparing }
BlFontWeightAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self weight hash
]

{ #category : #printing }
BlFontWeightAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-weight: ';
		nextPutAll: self weight asString
]

{ #category : #accessing }
BlFontWeightAttribute >> weight [
	^ weight
]

{ #category : #accessing }
BlFontWeightAttribute >> weight: aNumber [
	weight := aNumber
]
