"
I test the behavior of SpBlocPresenter and its Morphic adapter SpMorphicBlocAdapter.
"
Class {
	#name : #SpBlocPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'window',
		'space'
	],
	#category : #'Bloc-Spec2-Tests'
}

{ #category : #running }
SpBlocPresenterTest >> setUp [

	super setUp.
	presenter := SpBlocPresenter new.
	presenter application: (SpApplication new useBackend: #Morphic; yourself)
]

{ #category : #running }
SpBlocPresenterTest >> tearDown [

	window ifNotNil: [ window close ].
	space ifNotNil: [
		space close.
		space settle ].
	super tearDown
]

{ #category : #tests }
SpBlocPresenterTest >> testClickEventOnBlocElement [

	| element clicked |
	clicked := false.
	element :=
		BlElement new
			extent: 100 @ 50;
			addEventHandlerOn: BlClickEvent do: [ :anEvent | clicked := true ];
			yourself.
	presenter blocElement: element.
	window := presenter open.
	space := element space.
	space settle.
	self deny: clicked.

	element eventSimulator click.
	self assert: clicked
]

{ #category : #tests }
SpBlocPresenterTest >> testDefaultState [

	self assert: SpBlocPresenter adapterName equals: #BlocAdapter.
	self assert: presenter blocElement isNil
]

{ #category : #tests }
SpBlocPresenterTest >> testOpenWithBlocElement [

	| element |
	element := BlElement new extent: 100 @ 50; yourself.
	presenter blocElement: element.
	window := presenter open.
	space := element space.
	space settle.
	self assert: presenter adapter class equals: SpMorphicBlocAdapter.
	self assert: space isOpened.
	self assert: element isAttachedToSceneGraph.
	self assert: element parent equals: space root.
	self assert: space root children size equals: 1.
	self assert: element extent equals: 100 @ 50
]

{ #category : #tests }
SpBlocPresenterTest >> testReplaceAndClearBlocElement [

	| firstElement secondElement |
	firstElement := BlElement new extent: 100 @ 50; yourself.
	secondElement := BlElement new extent: 120 @ 60; yourself.
	presenter blocElement: firstElement.
	window := presenter open.
	space := firstElement space.
	space settle.
	self assert: firstElement isAttachedToSceneGraph.
	self assert: space root children size equals: 1.
	self assert: space root children first equals: firstElement.

	space deferAndSettle: [ presenter blocElement: secondElement ].
	self deny: firstElement isAttachedToSceneGraph.
	self deny: firstElement hasParent.
	self assert: secondElement isAttachedToSceneGraph.
	self assert: secondElement parent equals: space root.
	self assert: space root children size equals: 1.
	self assert: secondElement extent equals: 120 @ 60.

	space deferAndSettle: [ presenter blocElement: nil ].
	self deny: secondElement isAttachedToSceneGraph.
	self deny: secondElement hasParent.
	self assert: space root children isEmpty
]

{ #category : #tests }
SpBlocPresenterTest >> testSetBlocElementAfterOpen [

	| element |
	window := presenter open.
	self assert: presenter adapter class equals: SpMorphicBlocAdapter.
	self assert: presenter blocElement isNil.

	element := BlElement new extent: 80 @ 40; yourself.
	presenter blocElement: element.
	space := element space.
	space settle.
	self assert: space isOpened.
	self assert: element isAttachedToSceneGraph.
	self assert: element parent equals: space root.
	self assert: space root children size equals: 1.
	self assert: element extent equals: 80 @ 40
]

{ #category : #tests }
SpBlocPresenterTest >> testWhenBlocElementChangedDo [

	| firstElement secondElement changes |
	firstElement := BlElement new.
	secondElement := BlElement new.
	changes := OrderedCollection new.
	presenter whenBlocElementChangedDo: [ :newElement :oldElement | changes add: oldElement -> newElement ].

	presenter blocElement: firstElement.
	self assert: presenter blocElement equals: firstElement.
	self assert: changes size equals: 1.
	self assert: changes first key isNil.
	self assert: changes first value equals: firstElement.

	presenter blocElement: secondElement.
	self assert: presenter blocElement equals: secondElement.
	self assert: changes size equals: 2.
	self assert: changes second key equals: firstElement.
	self assert: changes second value equals: secondElement.

	presenter blocElement: nil.
	self assert: presenter blocElement isNil.
	self assert: changes size equals: 3.
	self assert: changes third key equals: secondElement.
	self assert: changes third value isNil
]

{ #category : #tests }
SpBlocPresenterTest >> testWidgetFillsPanedLayout [

	| container element widget |
	element := BlElement new extent: 100 @ 50; yourself.
	presenter blocElement: element.
	container := SpPresenter new.
	container application: presenter application.
	container layout:
		(SpPanedLayout newLeftToRight
			add: SpNullPresenter new;
			add: presenter;
			yourself).
	window := container open.
	space := element space.
	space settle.
	widget := presenter adapter widget.
	self assert: widget hResizing equals: #spaceFill.
	self assert: widget vResizing equals: #spaceFill
]

{ #category : #tests }
SpBlocPresenterTest >> testWindowCloseClosesSpace [

	| element |
	element := BlElement new extent: 100 @ 50; yourself.
	presenter blocElement: element.
	window := presenter open.
	space := element space.
	space settle.
	self assert: space isOpened.

	window close.
	window := nil.
	space settle.
	self deny: space isOpened.
	self assert: presenter adapter space isNil.
	presenter blocElement: BlElement new
]
