"
I represent a font weight attribute.
I am used together with BrText and BrTextStyler to style text.

Public API and Key Messages

- weight: set font weight in absolute units (100, 200, 400, 600, 800)

Example:

	BrFontWeightAttribute weight: 400.
	BrFontWeightAttribute bold.
	BrFontWeightAttribute normal.
	BrFontWeightAttribute thin
 
Internal Representation and Key Implementation Points.

    Instance Variables
	weight		<Number> 
"
Class {
	#name : #BrFontWeightAttribute,
	#superclass : #BrTextAttribute,
	#instVars : [
		'weight'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrFontWeightAttribute class >> bold [
	^ self new
		weight: LogicalFont weightBold;
		yourself
]

{ #category : #'instance creation' }
BrFontWeightAttribute class >> light [
	^ self new
		weight: LogicalFont weightLight;
		yourself
]

{ #category : #'instance creation' }
BrFontWeightAttribute class >> normal [
	^ self new
		weight: LogicalFont weightMedium;
		yourself
]

{ #category : #'instance creation' }
BrFontWeightAttribute class >> thin [
	^ self new
		weight: LogicalFont weightThin;
		yourself
]

{ #category : #'instance creation' }
BrFontWeightAttribute class >> weight: aNumber [
	^ self new
		weight: aNumber;
		yourself
]

{ #category : #comparing }
BrFontWeightAttribute >> equals: aTextAttribute [
	^ self weight = aTextAttribute weight
]

{ #category : #comparing }
BrFontWeightAttribute >> hash [
	^ self weight hash
]

{ #category : #printing }
BrFontWeightAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-weight: ';
		nextPutAll: self weight asString
]

{ #category : #accessing }
BrFontWeightAttribute >> weight [
	^ weight
]

{ #category : #accessing }
BrFontWeightAttribute >> weight: aNumber [
	weight := aNumber
]
