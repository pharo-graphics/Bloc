"
I have been automatically converted and probably manually tweaked from BlElementAttachmentExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementAttachmentTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Children'
}

{ #category : #tests }
BlElementAttachmentTest >> testAddToSpace [
	<sampleInstance>
	| aSpace aContainer aChild addedToScene removedFromScene |
	aSpace := BlOSpace new.
	aChild := BlElement new.
	aContainer := BlElement new.
	aContainer addChild: aChild.
	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	self assert: aContainer isRemovedFromSceneGraph.
	self assert: aChild isRemovedFromSceneGraph.
	aSpace addChild: aContainer.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self
		assert: addedToScene asArray
		equals:
			{aContainer.
			aChild}.
	self assert: removedFromScene asArray equals: {}.
	^ aContainer
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndAttachChild [
	<sampleInstance>
	| aContainer aChild addedToScene removedFromScene |
	aContainer := self testAddToSpace.
	aChild := aContainer children first.
	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aContainer detachChild: aChild.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent isNil.
	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.
	aContainer attachChild: aChild.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self assert: aChild space == aContainer space.
	self assert: aChild parent == aContainer.
	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.
	^ aContainer
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndRemoveChild [
	<sampleInstance>
	| aContainer aChild addedToScene removedFromScene |
	aContainer := self testAddToSpace.
	aChild := aContainer children first.
	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aContainer detachChild: aChild.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent isNil.
	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.
	aContainer removeDetachedChild: aChild.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isRemovedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent isNil.
	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {aChild}.
	^ aContainer
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachAndRemoveContainer [
	<sampleInstance>
	| aRoot aContainer aChild addedToScene removedFromScene |
	aContainer := self testAddToSpace.
	aChild := aContainer children first.
	aRoot := aContainer parent.
	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aRoot detachChild: aContainer.
	self assert: aContainer isDetachedFromSceneGraph.
	self assert: aContainer space isNil.
	self assert: aContainer parent isNil.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent == aContainer.
	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.
	aRoot removeDetachedChild: aContainer.
	self assert: aContainer isRemovedFromSceneGraph.
	self assert: aContainer space isNil.
	self assert: aContainer parent isNil.
	self assert: aChild isRemovedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent == aContainer.
	self assert: addedToScene asArray equals: {}.
	self
		assert: removedFromScene asArray
		equals:
			{aContainer.
			aChild}.
	^ aContainer
]

{ #category : #tests }
BlElementAttachmentTest >> testDetachRequestFocusAndAttachChild [
	<sampleInstance>
	| aContainer aChild focusEvents |
	aContainer := self testAddToSpace.
	aChild := aContainer children first.
	focusEvents := OrderedCollection new.
	aContainer
		when: BlFocusInEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].
	aChild
		when: BlFocusEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].
	self assert: aChild isFocused not.
	aContainer detachChild: aChild.
	aChild requestFocus.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph not.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent isNil.
	self assert: aChild isFocused.
	self assert: focusEvents asArray equals: {}.
	aContainer attachChild: aChild.
	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self assert: aChild space focusOwner equals: aChild.
	self
		assert: focusEvents asArray
		equals:
			{aContainer.
			aChild}.
	^ aContainer
]
