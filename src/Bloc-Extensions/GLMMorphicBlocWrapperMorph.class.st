"
I wrap a morphic host space window and listen for SystemWindow close events in order to close underlying bloc host window

"
Class {
	#name : #GLMMorphicBlocWrapperMorph,
	#superclass : #Morph,
	#instVars : [
		'space',
		'currentWindow'
	],
	#category : #'Bloc-Extensions-UI'
}

{ #category : #api }
GLMMorphicBlocWrapperMorph >> announceDeleted [
    super announceDeleted.

	currentWindow
		ifNil: [ ^ self closeSpace ].

	(self hasOwner: currentWindow)
		ifTrue: [ ^ self ].

	currentWindow isCollapsed
		ifTrue: [ ^ self ].

   self closeSpace
]

{ #category : #announcements }
GLMMorphicBlocWrapperMorph >> announceOpened [
	super announceOpened.

	self onAddedToWindow
]

{ #category : #api }
GLMMorphicBlocWrapperMorph >> closeSpace [
	self space
		ifNil: [ ^ self ].

	self space hasHostSpace
		ifTrue: [ self space close ]
]

{ #category : #finalization }
GLMMorphicBlocWrapperMorph >> finalize [
	self closeSpace.
	space at: 1 put: nil.
	currentWindow := nil
]

{ #category : #initialization }
GLMMorphicBlocWrapperMorph >> initialize [
	super initialize.
	
	space := WeakArray new: 1
]

{ #category : #announcements }
GLMMorphicBlocWrapperMorph >> intoWorld: aWorld [
	super intoWorld: aWorld.

	self showSpace
]

{ #category : #api }
GLMMorphicBlocWrapperMorph >> onAddedToWindow [
	currentWindow := self window.
	currentWindow announcer when: WindowClosed send: #onWindowClosed to: self
]

{ #category : #api }
GLMMorphicBlocWrapperMorph >> onWindowClosed [

	self closeSpace
]

{ #category : #api }
GLMMorphicBlocWrapperMorph >> showSpace [
	self space
		ifNil: [ ^ self ].
		
	self space isOpened
		ifTrue: [ ^ self ].

	self space show
]

{ #category : #accessing }
GLMMorphicBlocWrapperMorph >> space [
	<return: #BlSpace or: nil>

	^ space at: 1
]

{ #category : #accessing }
GLMMorphicBlocWrapperMorph >> space: aBlSpace [
	space at: 1 put: aBlSpace
]
