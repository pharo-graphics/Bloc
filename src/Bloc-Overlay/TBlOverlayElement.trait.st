"
An overlay element relocates and resizes itself to have exactly the same bounds as some reference element.
I'm used by BlOverlayElement but I can be reuse to make any BlElement behave as an overlay
see BlOverlayElement comment
"
Trait {
	#name : #TBlOverlayElement,
	#instVars : [
		'overlayListener',
		'overlayReferenceElement'
	],
	#category : #'Bloc-Overlay'
}

{ #category : #'t - overlay element - attaching / detaching' }
TBlOverlayElement >> attachTo: anElement [
	
	overlayReferenceElement = anElement
		ifTrue: [ ^ self ].
	
	self isAttached 
		ifTrue: [ self detach ].
	
	overlayReferenceElement := anElement.
	anElement addEventHandler: overlayListener
]

{ #category : #'t - overlay element - attaching / detaching' }
TBlOverlayElement >> detach [
	
	self isAttached
		ifFalse: [ ^ self ].
	
	overlayReferenceElement removeEventHandler: overlayListener.
	overlayReferenceElement := nil
]

{ #category : #'t - overlay element - geometry' }
TBlOverlayElement >> extentFrom: anExtent [

	^ anExtent
]

{ #category : #'t - overlay element - initialization' }
TBlOverlayElement >> initializeAsOverlayElement [

	overlayListener := self newOverlayListener.
	self constraintsDo: [ :c |
			c ignoreByLayout.
			c infinite holder startIgnoring ].
	self
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :event |
				self isAttached ifTrue: [
						overlayListener relocateTo: overlayReferenceElement.
						overlayListener resizeTo: overlayReferenceElement ] ]
]

{ #category : #'t - overlay element - testing' }
TBlOverlayElement >> isAttached [
	"Return true if I am attached to any element, false otherwise"
	<return: #Boolean>

	^ overlayReferenceElement isNotNil
]

{ #category : #'t - overlay element - instance creation' }
TBlOverlayElement >> newOverlayListener [

	^ BlOverlayListener for: self
]

{ #category : #'t - overlay element - geometry' }
TBlOverlayElement >> positionFrom: aPosition [

	^ aPosition
]
