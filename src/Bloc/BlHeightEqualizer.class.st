Class {
	#name : 'BlHeightEqualizer',
	#superclass : 'BlEqualizer',
	#instVars : [
		'heightBlock'
	],
	#category : 'Bloc-Utilities - Equalizer',
	#package : 'Bloc',
	#tag : 'Utilities - Equalizer'
}

{ #category : 'element handlers' }
BlHeightEqualizer >> elementExtentChangedEvent: anEvent [
	| maxHeight |

	maxHeight := self sourceElements max: #height.
	self targetElements do: [ :anElement | heightBlock value: anElement value: maxHeight ]
]

{ #category : 'accessing' }
BlHeightEqualizer >> height: aBlock [
	heightBlock := aBlock
]

{ #category : 'initialization' }
BlHeightEqualizer >> initialize [
	super initialize.
	
	heightBlock := [ :anElement :aHeight | anElement height: aHeight ]
]
