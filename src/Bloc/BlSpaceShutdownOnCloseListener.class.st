"
# Shutdown pharo when space is closed

When added to a ${class: BlSpace} I will shutdown Pharo as soon as that space is closed.
I can be configured to save the image before quitting by setting ${method:BlSpaceShutdownOnCloseListener>>#shouldSave:} to `true`.

Example: 
[[[
space := BlSpace new.
space title: 'Close me'.
space extent: 200@200.
space addEventHandler: BlSpaceShutdownOnCloseListener new.
space show
]]


"
Class {
	#name : #BlSpaceShutdownOnCloseListener,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'shouldSave'
	],
	#category : 'Bloc-Space - Events'
}

{ #category : #'api - event managing' }
BlSpaceShutdownOnCloseListener >> handleEvent: anEvent [
	| aSpace |
	aSpace := anEvent currentTarget.
	aSpace universe snapshot: shouldSave andQuit: true.
]

{ #category : #initialization }
BlSpaceShutdownOnCloseListener >> initialize [
	super initialize.
	
	shouldSave := false
]

{ #category : #accessing }
BlSpaceShutdownOnCloseListener >> shouldSave [
	<return: #Boolean>
	
	^ shouldSave
]

{ #category : #accessing }
BlSpaceShutdownOnCloseListener >> shouldSave: aBoolean [	
	"When set to true the image will be saved before quitting"

	shouldSave := aBoolean
]

{ #category : #'api - event managing' }
BlSpaceShutdownOnCloseListener >> wantsEvent: anEvent [
	^ anEvent class == BlSpaceClosedEvent
]
