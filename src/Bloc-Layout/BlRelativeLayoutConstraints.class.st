Class {
	#name : 'BlRelativeLayoutConstraints',
	#superclass : 'BlLayoutConstraints',
	#instVars : [
		'relativePosition'
	],
	#category : 'Bloc-Layout-Relative',
	#package : 'Bloc-Layout',
	#tag : 'Relative'
}

{ #category : 'initialization' }
BlRelativeLayoutConstraints >> initialize [
	super initialize.
	
	relativePosition := BlRelativeLayoutPositionUndefined new
]

{ #category : 'accessing' }
BlRelativeLayoutConstraints >> position [
	^ relativePosition
]

{ #category : 'accessing' }
BlRelativeLayoutConstraints >> position: anObject [
	relativePosition := anObject
]
