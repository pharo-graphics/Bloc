Class {
	#name : 'BlRelativeLayoutPositionAbove',
	#superclass : 'BlRelativeLayoutPosition',
	#instVars : [
		'anchorNode'
	],
	#category : 'Bloc-Layout-Relative',
	#package : 'Bloc-Layout',
	#tag : 'Relative'
}

{ #category : 'accessing' }
BlRelativeLayoutPositionAbove >> anchorNode [
	^ anchorNode
]

{ #category : 'accessing' }
BlRelativeLayoutPositionAbove >> anchorNode: anObject [
	anchorNode := anObject
]

{ #category : 'translation' }
BlRelativeLayoutPositionAbove >> translationOf: aBounds relativeTo: anAnchorBounds [
	<return: #Point>
	
	^ 0 @ (anAnchorBounds top - aBounds bottom)
]
