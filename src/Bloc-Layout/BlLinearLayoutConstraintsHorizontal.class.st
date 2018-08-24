Class {
	#name : #BlLinearLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment'
	],
	#category : 'Bloc-Layout-Linear'
}

{ #category : #alignment }
BlLinearLayoutConstraintsHorizontal >> alignCenter [
	alignment := BlElementAlignment horizontal center
]

{ #category : #alignment }
BlLinearLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : #alignment }
BlLinearLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : #accessing }
BlLinearLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : #accessing }
BlLinearLayoutConstraintsHorizontal >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
BlLinearLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment null horizontal
]
