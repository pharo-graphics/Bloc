"
I am an abstract Bloc OSWindow renderer. 
"
Class {
	#name : #BlOSWindowRenderer,
	#superclass : #OSWindowGLRenderer,
	#instVars : [
		'surface'
	],
	#category : #'BlocHost-OSWindow-Support'
}

{ #category : #'updating screen' }
BlOSWindowRenderer >> exposed [
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> resized [
	
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateAll [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateRectangle: aRectangle [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateRectangles: allDamage [
	self shouldNotImplement
]

{ #category : #'context activation' }
BlOSWindowRenderer >> withWindow: aWindow do: aBlock ifFailure: aFailureBlock [
	| oldContext oldWindow |

	oldContext := CurrentContext.
	oldWindow := CurrentWindow.
	[ 
		(self makeCurrent: aWindow) ifTrue: [
			CurrentContext := self.
			CurrentWindow := aWindow.
			aBlock value
		] ifFalse: [
			aFailureBlock value
		]
	] ensure: [
		(oldContext ~~ CurrentContext or: [ oldWindow ~~ CurrentWindow ]) ifTrue: [ 
			CurrentContext := oldContext.
			CurrentWindow := oldWindow.
			CurrentContext ifNotNil: [ CurrentContext makeCurrent: CurrentWindow ]
		]
	]
]
