"
I contain examples of space related events
"
Class {
	#name : #BlSpaceEventExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Event'
}

{ #category : #'instance creation' }
BlSpaceEventExamples >> space [
	<gtExample>
	
	^ BlSpace new
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceClosed [
	<gtExample>
	| aSpace spaceClosed |
	spaceClosed := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceClosedEvent do: [ spaceClosed := spaceClosed + 1 ].
	
	aSpace show.
	self assert: spaceClosed equals: 0.
	aSpace close.
	self assert: spaceClosed equals: 1.
	
	^ aSpace
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceShown [
	<gtExample>
	| aSpace spaceShown |
	spaceShown := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceShownEvent do: [ spaceShown := spaceShown + 1 ].

	aSpace show.
	self assert: spaceShown equals: 1.

	aSpace close.
	self assert: spaceShown equals: 1.
	
	
	^ aSpace
]
