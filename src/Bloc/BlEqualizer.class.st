"
I am used to equalize the size of multiple target element with the size of the source elements.

I force Bloc to perform two layout passes, the first one to compute the size of the souce elements and then the second pass that applies the size to target elements.

Use me with caution then and only then when there is no other solution, and you  to to equalize the size

"
Class {
	#name : 'BlEqualizer',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'sourceElements',
		'targetElements'
	],
	#category : 'Bloc-Utilities - Equalizer'
}

{ #category : 'instance creation' }
BlEqualizer class >> of: aCollectionOfTargetElements with: aCollectionOfSourceElements [
	^ self new
		sourceElements: aCollectionOfSourceElements;
		targetElements: aCollectionOfTargetElements
]

{ #category : 'api - accessing' }
BlEqualizer >> eventsToHandle [
	^ { BlElementExtentChangedEvent }
]

{ #category : 'accessing' }
BlEqualizer >> sourceElements [
	^ sourceElements
]

{ #category : 'accessing' }
BlEqualizer >> sourceElements: aCollection [
	sourceElements := aCollection.
	sourceElements do: [ :anElement | anElement addEventHandler: self ]
]

{ #category : 'accessing' }
BlEqualizer >> targetElements [
	^ targetElements
]

{ #category : 'accessing' }
BlEqualizer >> targetElements: anObject [
	targetElements := anObject
]
