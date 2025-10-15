Class {
	#name : #BlSlideHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'dragStartPosition',
		'targetElement'
	],
	#category : #'Bloc-PullAndSlide-Handlers'
}

{ #category : #'dnd handlers' }
BlSlideHandler >> dragEvent: anEvent [

	| aStartPosition aCurrentPosition aDelta aTargetElement |
	anEvent consume.
	aTargetElement := targetElement ifNil: [ anEvent currentTarget ].

	aStartPosition := aTargetElement globalPointToChildren: dragStartPosition.
	aCurrentPosition := aTargetElement globalPointToChildren: anEvent position.

	aDelta := (aCurrentPosition - aStartPosition) rounded.

	aTargetElement children accountedByLayout do: [ :aChild |
		| aChildStartPosition |

		aChildStartPosition := aChild userData
			at: #slideHandlerStartPosition
			ifAbsentPut: [ aChild constraints position ].
		
		aChild relocate: aChildStartPosition + aDelta ]
]

{ #category : #'dnd handlers' }
BlSlideHandler >> dragStartEvent: anEvent [

	anEvent consume.

	"drag start position in space"
	dragStartPosition := anEvent position.
	
	(targetElement ifNil: [ anEvent currentTarget ]) children accountedByLayout
		do: [ :aChild |
			aChild userData
				at: #slideHandlerStartPosition
				put: aChild constraints position ]
]

{ #category : #accessing }
BlSlideHandler >> targetElement [
	^ targetElement
]

{ #category : #accessing }
BlSlideHandler >> targetElement: anObject [
	targetElement := anObject
]
