"
I contain examples related to ===BlCompositor===
"
Class {
	#name : #BlCompositorExamples,
	#superclass : #Object,
	#category : 'Bloc-Compositor'
}

{ #category : #'examples - compositor' }
BlCompositorExamples >> compositorRendering [
	<gtExample>
	| element canvas compositor |

	element := self elementWithElevatedChildren.
	element forceLayout.
	
	canvas := MozCanvas checker: element extent.
	compositor := BlCompositor on: element.
	compositor drawOnSpartaCanvas: canvas.
	
	^ canvas
]

{ #category : #'instance creation' }
BlCompositorExamples >> element [
	<gtExample>
	
	^ BlElement new
]

{ #category : #'examples - elevation' }
BlCompositorExamples >> elementWithElevatedChildren [
	<gtExample>
	| parent child1 childInside child2 |
	
	parent := self elementWithZeroRelativeElevation
		size: 200 @ 200;
		relocate: 20@0;
		background: (Color blue alpha: 0.2).

	child1 := self elementWithRelativeElevation20
		size: 50 @ 50;
		relocate: 0@10;
		background: (Color red alpha: 0.9).
	
	childInside := self elementWithGlobalElevation10
		size: 75 @ 75;
		background: (Color pink alpha: 0.9).
	
	child2 := self elementWithZeroRelativeElevation
		size: 100 @ 100;
		background: (Color green alpha: 0.8).

	child1 addChild: childInside.
	
	parent addChildren: { child1. child2 }.
	
	^ parent
]

{ #category : #'examples - elevation' }
BlCompositorExamples >> elementWithGlobalElevation10 [
	<gtExample>

	^ self element
		elevation: self globalElevation10
]

{ #category : #'examples - elevation' }
BlCompositorExamples >> elementWithRelativeElevation20 [
	<gtExample>

	^ self element
		elevation: self relativeElevation20
]

{ #category : #'examples - elevation' }
BlCompositorExamples >> elementWithZeroRelativeElevation [
	<gtExample>

	^ self element
		elevation: self zeroRelativeElevation
]

{ #category : #'examples - compositor' }
BlCompositorExamples >> elevationTree [
	<gtExample>
	| element compositor |
	
	element := self elementWithElevatedChildren.
	element forceLayout.

	compositor := BlCompositor new.
	
	^ compositor buildElevationTree: element
]

{ #category : #'instance creation' }
BlCompositorExamples >> globalElevation10 [
	<gtExample>
	
	^ BlGlobalElevation elevation: 10
]

{ #category : #'examples - compositor' }
BlCompositorExamples >> mouseDownOnNodesBelowThePoint [
	<gtExample>
	| theNodes mouseEvent theEvents |
	
	theEvents := OrderedCollection new.

	mouseEvent := BlMouseDownEvent new.
	mouseEvent timestamp: DateAndTime now.
	mouseEvent button: BlMouseButton primary.
	mouseEvent position: 20@20.

	theNodes := self nodesBelowThePoint.
	theNodes linksDo: [ :aNode |
		aNode
			addEventHandlerOn: BlMouseDownEvent
			do: [ :anEvent | theEvents add: anEvent ] ].

	theNodes firstLink fireEvent: mouseEvent.
	^ theEvents
]

{ #category : #'examples - compositor' }
BlCompositorExamples >> nodesBelowThePoint [
	<gtExample>
	| elevationTree |

	elevationTree := self elevationTree.
	^ elevationTree nodesAt: 20@20
]

{ #category : #'instance creation' }
BlCompositorExamples >> relativeElevation20 [
	<gtExample>
	
	^ BlRelativeElevation elevation: 20
]

{ #category : #'instance creation' }
BlCompositorExamples >> zeroRelativeElevation [
	<gtExample>
	
	^ BlRelativeElevation elevation: 0
]
