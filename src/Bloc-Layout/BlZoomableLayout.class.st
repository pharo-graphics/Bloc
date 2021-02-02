Class {
	#name : #BlZoomableLayout,
	#superclass : #BlCompositeLayout,
	#instVars : [
		'animationDuration',
		'defaultScale'
	],
	#category : #'Bloc-Layout-Zoomable'
}

{ #category : #constraints }
BlZoomableLayout class >> constraints [
	^ BlZoomableLayoutConstraints new
]

{ #category : #accessing }
BlZoomableLayout >> animationDuration [
	^ animationDuration
]

{ #category : #accessing }
BlZoomableLayout >> animationDuration: anObject [
	animationDuration := anObject
]

{ #category : #accessing }
BlZoomableLayout >> defaultScale [
	^ defaultScale
]

{ #category : #accessing }
BlZoomableLayout >> defaultScale: anObject [
	defaultScale := anObject
]

{ #category : #adding }
BlZoomableLayout >> initialize [
	super initialize.
	
	defaultScale := 0.35.
	animationDuration := 0 milliSeconds
]

{ #category : #measure }
BlZoomableLayout >> measure: aParentLayoutNode [
	| theCurrentZoomInterval theCurrentZoomFactor theBoundingBox aPreviousBoundingBox |

	aParentLayoutNode childrenDo: [ :eachChildNode |
		eachChildNode constraints shouldAccountTransformation
			ifFalse: [ eachChildNode constraints zoomable scaleFactor: 1 ].
		eachChildNode pushAction: (BlZoomableLayoutElementAction new animationDuration: self animationDuration) ].

	(self measureWithDefaultZoom: aParentLayoutNode)
		ifTrue: [ ^ self ].
	
	theBoundingBox := aParentLayoutNode children boundingBox.
	
	theCurrentZoomInterval := 0 -> self defaultScale.
	theCurrentZoomFactor := self defaultScale.
	aPreviousBoundingBox := theBoundingBox.
	
	[
		| aTransformation |
		theCurrentZoomFactor := theCurrentZoomInterval key + ((theCurrentZoomInterval value - theCurrentZoomInterval key) / 2.0).

		aTransformation := BlElementTransformation scale: theCurrentZoomFactor.
		aParentLayoutNode children: (aParentLayoutNode children collect: [ :eachChildNode |
			eachChildNode constraints shouldAccountTransformation
				ifTrue: [ eachChildNode withTransformation: aTransformation ]
				ifFalse: [ eachChildNode ] ]).
	
		"targetLayout measure: aParentLayoutNode."
		BlRelativeLayout new layout: aParentLayoutNode.
		
		theBoundingBox := aParentLayoutNode children boundingBox.
		
		(aPreviousBoundingBox extent closeTo: theBoundingBox extent)
			ifFalse: [
				| shouldZoomOut shouldRemeasure |

				aPreviousBoundingBox := theBoundingBox.
				shouldZoomOut := theBoundingBox width > aParentLayoutNode extent x or: [ theBoundingBox height > aParentLayoutNode extent y ].
				shouldZoomOut
					ifTrue: [ theCurrentZoomInterval := theCurrentZoomInterval key -> theCurrentZoomFactor ]
					ifFalse: [ theCurrentZoomInterval := theCurrentZoomFactor -> theCurrentZoomInterval value ].

				shouldRemeasure := shouldZoomOut
					ifTrue: [ true ]
					ifFalse: [ (theBoundingBox extent - aParentLayoutNode extent) abs max > 10 ].
				shouldRemeasure ]
			ifTrue: [ false ]
	] whileTrue.

	aParentLayoutNode children do: [ :eachChildNode |
		eachChildNode constraints shouldAccountTransformation
			ifTrue: [ eachChildNode constraints zoomable scaleFactor: theCurrentZoomFactor ] ]
]

{ #category : #measure }
BlZoomableLayout >> measureWithDefaultZoom: aParentLayoutNode [
	| theBoundingBox aTransformation |
	
	aTransformation := BlElementTransformation scale: self defaultScale.
		aParentLayoutNode children: (aParentLayoutNode children collect: [ :eachChildNode |
			eachChildNode constraints shouldAccountTransformation
				ifTrue: [ eachChildNode withTransformation: aTransformation ]
				ifFalse: [ eachChildNode withoutTransformation ] ]).

	super measure: aParentLayoutNode.
	theBoundingBox := aParentLayoutNode children boundingBox.
	
	theBoundingBox extent <= aParentLayoutNode extent
		ifFalse: [ ^ false ].

	aParentLayoutNode childrenDo: [ :eachChildNode |
		eachChildNode constraints shouldAccountTransformation
			ifTrue: [ eachChildNode constraints zoomable scaleFactor: self defaultScale ] ].

	^ true
]
