Class {
	#name : #BlIgnoredLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment',
		'weight'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #alignment }
BlIgnoredLayoutConstraintsVertical >> alignBottom [
	alignment := BlElementAlignment vertical end
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsVertical >> alignCenter [
	alignment := BlElementAlignment vertical center
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsVertical >> alignNone [
	alignment := BlElementAlignment vertical null
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsVertical >> alignTop [
	alignment := BlElementAlignment vertical start
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsVertical >> alignment [
	^ alignment
]

{ #category : #initialization }
BlIgnoredLayoutConstraintsVertical >> initialize [
	super initialize.
	
	alignment := BlElementAlignment vertical null.
	weight := 1.0
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsVertical >> weight [
	<return: #Number>

	^ weight
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsVertical >> weight: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight can not be negative' ].

	weight := aNumber
]
