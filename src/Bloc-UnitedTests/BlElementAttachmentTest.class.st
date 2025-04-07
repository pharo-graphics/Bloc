"
I have been automatically converted and probably manually tweaked from BlElementAttachmentExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementAttachmentTest,
	#superclass : #TestCase,
	#instVars : [
		'addedToScene',
		'removedFromScene',
		'space',
		'leaf',
		'container'
	],
	#category : #'Bloc-UnitedTests-Children'
}

{ #category : #running }
BlElementAttachmentTest >> setUp [

	super setUp.

	space := BlSpace new.
	leaf := BlElement new.
	container := BlElement new.
	container addChild: leaf.
	space root addChild: container.
	
	addedToScene := OrderedCollection new.
	container
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	leaf
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].

	removedFromScene := OrderedCollection new.
	container
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		 do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	leaf
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].


]

{ #category : #tests }
BlElementAttachmentTest >> testAddToSpace [

	"Override setUp to check the very initial state."
	space := BlSpace new.
	leaf := BlElement new.
	container := BlElement new.
	container addChild: leaf.
	addedToScene := OrderedCollection new.
	container
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	leaf
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].

	self deny: container isAttachedToSceneGraph.
	self deny: leaf isAttachedToSceneGraph.

	space root addChild: container.
	
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isAttachedToSceneGraph.
	self assert: addedToScene asArray equals: { container. leaf }.
	self assert: removedFromScene asArray equals: {  }
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndAttachChild [

	container detachChild: leaf.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isDetachedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent isNil.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: {  }.
	container attachChild: leaf.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isAttachedToSceneGraph.
	self assert: leaf space identicalTo: container space.
	self assert: leaf parent identicalTo: container.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: {  }
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndRemoveChild [

	container detachChild: leaf.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isDetachedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent isNil.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: {  }.
	container removeDetachedChild: leaf.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isRemovedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent isNil.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: { leaf }
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndRemoveContainer [

	| aRoot |
	aRoot := container parent.

	aRoot detachChild: container.
	self assert: container isDetachedFromSceneGraph.
	self assert: container space isNil.
	self assert: container parent isNil.
	self assert: leaf isDetachedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent identicalTo: container.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: {  }.
	aRoot removeDetachedChild: container.
	self assert: container isRemovedFromSceneGraph.
	self assert: container space isNil.
	self assert: container parent isNil.
	self assert: leaf isRemovedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent identicalTo: container.
	self assert: addedToScene asArray equals: {  }.
	self assert: removedFromScene asArray equals: { container. leaf }.

]

{ #category : #tests }
BlElementAttachmentTest >> testDetachRequestFocusAndAttachChild [

	| focusEvents |
	focusEvents := OrderedCollection new.
	container
		addEventHandlerOn: BlFocusInEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].
	leaf
		addEventHandlerOn: BlFocusEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].

	self deny: leaf isFocused.

	container detachChild: leaf.
	leaf requestFocus.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isAttachedToSceneGraph not.
	self assert: leaf isDetachedFromSceneGraph.
	self assert: leaf space isNil.
	self assert: leaf parent isNil.
	self assert: leaf isFocused.
	self assert: focusEvents asArray equals: {  }.

	container attachChild: leaf.
	self assert: container isAttachedToSceneGraph.
	self assert: leaf isAttachedToSceneGraph.
	self assert: leaf space focusOwner equals: leaf.
	self assert: focusEvents asArray equals: { leaf. container }.

]
