Class {
	#name : #GLMBlocMondrianPresentation,
	#superclass : #GLMPresentation,
	#traits : 'TGLMBlocPresentation',
	#classTraits : 'TGLMBlocPresentation classTrait',
	#instVars : [
		'paintingBlock',
		'shouldInstallClicksOnNodes',
		'viewInitializer',
		'shouldInstallClicksOnEdges',
		'createdElement'
	],
	#category : 'Bloc-Extensions-Presentations'
}

{ #category : #initialization }
GLMBlocMondrianPresentation >> createDefaultView [
	^ (self class environment classNamed: #GtMondrian) new
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> defaultActions [
	self act: [ :aBlocPresentation | aBlocPresentation element zoomToActualSize ]
			icon: (Smalltalk ui icons iconNamed: #checkBoxPressed)
			entitled: 'Actual size';
		act: [ :aBlocPresentation | aBlocPresentation element zoomIn ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in';
		act: [ :aBlocPresentation | aBlocPresentation element zoomOut ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :aBlocPresentation | aBlocPresentation element zoomToFit ]
			icon: GLMUIThemeExtraIcons glamorousZoomToFit
			entitled: 'Zoom to fit';
		act: [ :aBlocPresentation :aGtMondrian | aGtMondrian inspect ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			entitled: 'Inspect'
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> element [
	<return: #BlElement>
	| view |
	
	"returned a cached created element or create a new one"
	createdElement
		ifNotNil: [ ^ createdElement ].
	
	view := viewInitializer value.
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	shouldInstallClicksOnNodes ifTrue: [ 
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target withAllParentsDo: [ :element |
				element graph isNode
					ifTrue: [
						anEvent consumed: true.
						self selection: element graph model ] ] ] ].
	shouldInstallClicksOnEdges ifTrue: [
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target withAllParentsDo: [ :element |
				element graph isEdge
					ifTrue: [
						anEvent consumed: true.
						self selection: element graph model ] ] ] ].
	view topStep root 
		when: GLMBlocObjectToSelect 
		do: [:signal | self selection: signal toSelect ].

	^ createdElement := view asPannableElement
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> initialize [
	super initialize.
	paintingBlock := [ :aGtMondrian :theDisplayValue | ].
	viewInitializer := [ self createDefaultView ].
	self withNodeClicks.
	self withEdgeClicks.
	self defaultActions
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> initializeView: aBlock [
	viewInitializer := aBlock
]

{ #category : #testing }
GLMBlocMondrianPresentation >> isAvailable [
	^ self class environment hasClassNamed: #GtMondrian
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> painting: aBlock [
	paintingBlock := aBlock
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderBlocMondrianPresentation: self
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> withEdgeClicks [
	shouldInstallClicksOnEdges := true
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> withNodeClicks [
	shouldInstallClicksOnNodes := true
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> withoutEdgeClicks [
	shouldInstallClicksOnEdges := false
]

{ #category : #scripting }
GLMBlocMondrianPresentation >> withoutNodeClicks [
	shouldInstallClicksOnNodes := false
]
