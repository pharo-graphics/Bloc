Class {
	#name : #BlWidthEqualizer,
	#superclass : #BlEqualizer,
	#instVars : [
		'sourceElements',
		'targetElements'
	],
	#category : 'Bloc-Utilities - Equalizer'
}

{ #category : #'as yet unclassified' }
BlWidthEqualizer class >> of: aCollectionOfTargetElements with: aCollectionOfSourceElements [
	^ self new
		sourceElements: aCollectionOfSourceElements;
		targetElements: aCollectionOfTargetElements
]

{ #category : #'element handlers' }
BlWidthEqualizer >> elementExtentChanged: anEvent [
	| maxWidth |

	maxWidth := self sourceElements max: #width.
	self targetElements do: [ :anElement | anElement width: maxWidth ]
]

{ #category : #accessing }
BlWidthEqualizer >> sourceElements [
	^ sourceElements
]

{ #category : #accessing }
BlWidthEqualizer >> sourceElements: aCollection [
	sourceElements := aCollection.
	sourceElements do: [ :anElement | anElement addEventHandler: self ]
]

{ #category : #accessing }
BlWidthEqualizer >> targetElements [
	^ targetElements
]

{ #category : #accessing }
BlWidthEqualizer >> targetElements: anObject [
	targetElements := anObject
]
