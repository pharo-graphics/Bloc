"
BlAsyncElementValuable is an abstract class that collaborates with BlAsyncElement to asynchronously update the state of BlAsyncElements with minimal impact on UI responsiveness.

BlAsyncElementValuable works with ${class:name=BlAsyncUIWorkerPool}$ to ensure that elements that are currently visible on the screen are updated before elements that are not visible by prioritising tasks based on the elements visibility and distance from the viewable area, see ${method:name=BlAsyncElementValuable>>#taskPriority}$.

Subclasses are responsible for deterining the contents and update their element, see ${method:name=BlAsyncElementValuable>>#updateElement}$.


!!Public API and Key Messages
Subclasses of BlAsyncElementValuable typically create their own instance creation methods.

!!Internal Representation and Key Implementation Points

!!!Instance Variables
	element:		<BlAsyncElement> The element being udpated by the receiver


"
Class {
	#name : #BlAsyncElementValuable,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Async'
}

{ #category : #accessing }
BlAsyncElementValuable class >> element: aBlElement [

	^self new element: aBlElement 
]

{ #category : #converting }
BlAsyncElementValuable >> asTask [ 

	^TKTTask valuable: self
]

{ #category : #accessing }
BlAsyncElementValuable >> element [
	^ element
]

{ #category : #accessing }
BlAsyncElementValuable >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlAsyncElementValuable >> entryPriority [
	"Answer the task priority of the receiver.
	If the element is visible, answer 0 (highest priority), otherwise answer the distance from the center of the display"

	| rootBounds elementBounds |

	element isAttachedToSceneGraph ifFalse: 
		"The element is being pre-loaded, so is lower priority than on-screen elements"
		[ ^5000 ].

	"If a priority has been specified, use that"
	element priority ifNotNil: [ ^element priority ].

	"Determine the of the element and its space (in the parent's coordinate system).
	It may be that the element only takes up part of the space, so this is an approximation.
	ToDo: Be able to set the parent element which should be used to calculate the distance"
	rootBounds := element visibleElement boundsInSpace.
	elementBounds := element boundsInSpace.

	"If the element is visible, load at high priority"
	(rootBounds containsRect: elementBounds) ifTrue: [ ^1 ].
	"Otherwise, priority is proportional to distance from viewable area"
	^rootBounds center distanceTo: elementBounds center
]

{ #category : #acccessing }
BlAsyncElementValuable >> extent [ 
	"Answer the receiver's element extent if open, or nil"

	| extent |

	extent := element extent.
	^(extent x = 0 or: [ extent y = 0 ]) 
		ifTrue: [ nil ]
		ifFalse: [ extent ]
]

{ #category : #private }
BlAsyncElementValuable >> updateElement [
	"Update the receiver's element"

	self subclassResponsibility
]

{ #category : #evaluating }
BlAsyncElementValuable >> value [

	^[ element needsUpdate 
			ifTrue: [ self updateElement ]
			ifFalse: [ nil ] ]
		on: Error
		do: [ :ex | element asyncException: ex ]
]
