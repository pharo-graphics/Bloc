Class {
	#name : #BlLinearLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment'
	],
	#category : 'Bloc-Layout-Linear'
}

{ #category : #alignment }
BlLinearLayoutConstraintsVertical >> alignBottom [
	alignment := BlElementAlignment vertical end
]

{ #category : #alignment }
BlLinearLayoutConstraintsVertical >> alignCenter [
	alignment := BlElementAlignment vertical center
]

{ #category : #alignment }
BlLinearLayoutConstraintsVertical >> alignTop [
	alignment := BlElementAlignment vertical start
]

{ #category : #accessing }
BlLinearLayoutConstraintsVertical >> alignment [
	^ alignment
]

{ #category : #accessing }
BlLinearLayoutConstraintsVertical >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
BlLinearLayoutConstraintsVertical >> initialize [
	super initialize.
	
	alignment := BlElementAlignment null vertical
]
