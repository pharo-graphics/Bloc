Class {
	#name : #BlPannableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomableElement'
	],
	#category : #'Bloc-Utilities - Pannable'
}

{ #category : #conversion }
BlPannableElement >> asPannableElement [
	^ self
]

{ #category : #conversion }
BlPannableElement >> asScalableElement [
	^ self
]

{ #category : #conversion }
BlPannableElement >> asScrollableElement [
	^ self
]

{ #category : #accessing }
BlPannableElement >> contentElement [
	^ self zoomableElement contentElement
]

{ #category : #accessing }
BlPannableElement >> contentElement: anElement [
	self zoomableElement contentElement: anElement.
	self zoomToFit
]

{ #category : #ui }
BlPannableElement >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons zoomin asElement;
				action: [ self zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons zoomout asElement;
				action: [ self zoomOut ] ];
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons zoomtofit asElement;
				action: [ self zoomToFit ] ];
		actionStencil: [ 
			BrButton new
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons actualsize asElement;
				action: [ self zoomToActualSize ] ]
]

{ #category : #'api - testing' }
BlPannableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>

	^ zoomableElement hasContentElement
]

{ #category : #initialization }
BlPannableElement >> initialize [
	super initialize.
	
	zoomableElement := BlZoomableElement new.
	self addEventHandler: BlSlideHandler new.
	
	self addChild: zoomableElement
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomIn [
	self zoomableElement zoomIn
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomOut [
	self zoomableElement zoomOut
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomTo: aZoomFactor [
	self zoomableElement zoomLevel: aZoomFactor
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomToActualSize [
	self zoomTo: 1
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomToFit [
	self zoomableElement zoomReset
]

{ #category : #accessing }
BlPannableElement >> zoomableElement [
	<return: #BlZoomableElement>
	
	^ zoomableElement
]
