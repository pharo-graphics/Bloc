Class {
	#name : 'BlWidthEqualizer',
	#superclass : 'BlEqualizer',
	#instVars : [
		'widthBlock'
	],
	#category : 'Bloc-Utilities - Equalizer'
}

{ #category : 'element handlers' }
BlWidthEqualizer >> elementExtentChangedEvent: anEvent [
	| maxWidth |

	maxWidth := self sourceElements max: #width.
	self targetElements do: [ :anElement | widthBlock value: anElement value: maxWidth ]
]

{ #category : 'initialization' }
BlWidthEqualizer >> initialize [
	super initialize.
	
	widthBlock := [ :anElement :aWidth | anElement width: aWidth ]
]

{ #category : 'accessing' }
BlWidthEqualizer >> width: aBlock [
	widthBlock := aBlock
]
