"
BlOSpace is kept to keep track of all space uses for testing/example and event simulation purpose.
It should be removed as soon as we convert all the examples as tests and move event simulation methods to a dedicated class.

"
Class {
	#name : 'BlOSpace',
	#superclass : 'BlSpace',
	#category : 'Bloc-Space',
	#package : 'Bloc',
	#tag : 'Space'
}

{ #category : 'change - style' }
BlOSpace class >> doStyle: anElement [
	| theInheritedStates childSpecificStatesToInherit |
			
	theInheritedStates := BlElementStatesSet new.
	childSpecificStatesToInherit := theInheritedStates.

	anElement hasParent
		ifTrue: [
			theInheritedStates := anElement parent states statesToInherit.
			theInheritedStates do: [ :eachState | eachState prepareToPropagateFrom: anElement parent ].
			childSpecificStatesToInherit := theInheritedStates collect: [ :eachState |
				eachState propagatedStateFrom: anElement parent to: anElement ]. ].
	
	self doStyle: anElement withInheritedStates: childSpecificStatesToInherit.
	
	theInheritedStates do: [ :eachState | eachState finishedPropagateFrom: anElement ]
]

{ #category : 'change - style' }
BlOSpace class >> doStyle: anElement withInheritedStates: aCollectionOfStates [
	| theStatesToInherit allNewStates newInheritedStates |

	anElement states ifNil: [ ^ self ].
	anElement states inheritedStates: aCollectionOfStates.
	allNewStates := anElement states allStates.
	
	newInheritedStates := aCollectionOfStates intersection: allNewStates.
	newInheritedStates do: [ :eachNewInheritedState | eachNewInheritedState optionalOnAddedTo: anElement ].
	
	anElement styles applyStylesForStates: allNewStates.

	theStatesToInherit := anElement states statesToInherit.
	theStatesToInherit do: [ :eachState | eachState prepareToPropagateFrom: anElement ].

	anElement children do: [ :eachChild |
		| childSpecificStatesToInherit |

		childSpecificStatesToInherit := theStatesToInherit collect: [ :eachState |
			eachState propagatedStateFrom: anElement to: eachChild ].

		self
			doStyle: eachChild
			withInheritedStates: childSpecificStatesToInherit ].

	theStatesToInherit do: [ :eachState | eachState finishedPropagateFrom: anElement ]
]

{ #category : 'api - adding children' }
BlOSpace >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : 'children - accessing' }
BlOSpace >> children [

	^ self root children
]

{ #category : 'focus managing' }
BlOSpace >> looseFocusFor: anElement [
			
	self
		deprecated: 'Please use loseFocusFor: instead.'
		transformWith:
			'`@receiver looseFocusFor: `@statements1'
				-> '`@receiver loseFocusFor: `@statements1'.
				
	self loseFocusFor: anElement
]

{ #category : 'api - adding children' }
BlOSpace >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]
