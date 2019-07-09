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

{ #category : #initialization }
BlOSWindowRenderer >> initializeForBuffer: aBlHostRendererBufferSurface [
	self subclassResponsibility
]

{ #category : #initialization }
BlOSWindowRenderer >> initializeForForm: aBlHostRendererFormSurface [
	self subclassResponsibility
]

{ #category : #'host space - drawing' }
BlOSWindowRenderer >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	self subclassResponsibility
]

{ #category : #'host space - drawing' }
BlOSWindowRenderer >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	self subclassResponsibility
]

{ #category : #'updating resources' }
BlOSWindowRenderer >> resetResources [
	surface initializeOn: self
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> resized [
	self resetResources
]

{ #category : #accessing }
BlOSWindowRenderer >> surface: aBlSurface [
	surface := aBlSurface
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
