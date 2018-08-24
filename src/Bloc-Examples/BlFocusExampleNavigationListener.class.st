"
I am a keyboard arrow press listener used by focus examples in order to move focus between cell elements
"
Class {
	#name : #BlFocusExampleNavigationListener,
	#superclass : #BlElementEventListener,
	#category : 'Bloc-Examples-Focus'
}

{ #category : #'keyboard handlers' }
BlFocusExampleNavigationListener >> keyDownEvent: anEvent [
	| root focused focusFinder next direction |
	
	root := anEvent currentTarget.
	
	root hasFocus
		ifFalse: [ ^ self ].

	focused := root focusedChild.
	[ focused focusedChild isNotNil ]
		whileTrue: [ focused := focused focusedChild ].
	
	focusFinder := BlFocusFinder new.
	direction := nil.
	next := nil.
			
	anEvent key = Key arrowLeft
		ifTrue: [ direction := BlFocusSearchDirectionLeft new ].
	anEvent key = Key arrowUp
		ifTrue: [ direction := BlFocusSearchDirectionUp new ].
	anEvent key = Key arrowRight
		ifTrue: [ direction := BlFocusSearchDirectionRight new ].
	anEvent key = Key arrowDown
		ifTrue: [ direction := BlFocusSearchDirectionDown new ].
				
	next := direction ifNotNil: [ :aDirection |
		focusFinder nextFocus: focused within: root along: aDirection ].
	next ifNotNil: #transferFocus
]
