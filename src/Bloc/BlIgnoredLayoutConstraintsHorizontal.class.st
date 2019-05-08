Class {
	#name : #BlIgnoredLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment',
		'weight'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignCenter [
	alignment := BlElementAlignment horizontal center
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : #initialization }
BlIgnoredLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment horizontal null.
	weight := 1.0
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> weight [
	<return: #Number>

	^ weight
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> weight: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight can not be negative' ].

	weight := aNumber
]
