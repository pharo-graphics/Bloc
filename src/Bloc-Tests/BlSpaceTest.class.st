Class {
	#name : #BlSpaceTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceTest >> testBorderless [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self deny: aSpace isBorderless.

	aSpace borderless: true.
	self assert: aSpace isBorderless.

	aSpace
		show;
		settle.
	self assert: aSpace isBorderless.

	aSpace borderless: false.
	self deny: aSpace isBorderless
]

{ #category : #tests }
BlSpaceTest >> testExtent [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	aSpace extent: 600 @ 400.
	self assert: aSpace extent equals: 600 @ 400.

	aSpace
		show;
		settle.
	self assert: aSpace extent equals: 600 @ 400.

	aSpace extent: 800 @ 500.
	self assert: aSpace extent equals: 800 @ 500
]

{ #category : #tests }
BlSpaceTest >> testFullscreen [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self deny: aSpace isFullscreen.

	aSpace fullscreen: true.
	self assert: aSpace isFullscreen.

	aSpace
		show;
		settle.
	self assert: aSpace isFullscreen.

	aSpace fullscreen: false.
	self deny: aSpace isFullscreen
]

{ #category : #tests }
BlSpaceTest >> testFullsize [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self deny: aSpace isFullsize.

	aSpace fullsize: true.
	self assert: aSpace isFullsize.

	aSpace
		show;
		settle.
	self assert: aSpace isFullsize.

	aSpace fullsize: false.
	self deny: aSpace isFullsize
]

{ #category : #tests }
BlSpaceTest >> testHideAndShow [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self deny: aSpace isVisible.

	aSpace
		show;
		settle.
	self assert: aSpace isVisible.

	aSpace hide.
	self deny: aSpace isVisible.

	aSpace
		show;
		settle.
	self assert: aSpace isVisible
]

{ #category : #tests }
BlSpaceTest >> testMaximize [

	| aSpace |
	aSpace := self newTestingSpace.
	self deny: aSpace maximized.

	aSpace maximize.
	self assert: aSpace maximized
]

{ #category : #tests }
BlSpaceTest >> testMinimize [

	| aSpace |
	aSpace := self newTestingSpace.
	self deny: aSpace minimized.

	aSpace minimize.
	self assert: aSpace minimized
]

{ #category : #tests }
BlSpaceTest >> testPosition [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self deny: aSpace knowsPosition.

	aSpace position: 120 @ 80.
	self assert: aSpace knowsPosition.
	self assert: aSpace position equals: 120 @ 80.

	aSpace
		show;
		settle.
	self assert: aSpace position equals: 120 @ 80.

	aSpace position: 200 @ 300.
	self assert: aSpace position equals: 200 @ 300
]

{ #category : #tests }
BlSpaceTest >> testResizable [

	| aSpace |
	aSpace := self newUnopenedTestingSpace.
	self assert: aSpace isResizable.
	aSpace resizable: false.
	self deny: aSpace isResizable.

	aSpace
		show;
		settle.
	self deny: aSpace isResizable.

	aSpace resizable: true.
	self assert: aSpace isResizable
]

{ #category : #tests }
BlSpaceTest >> testTitle [

	| aSpace |
	self assert: BlSpace new title isEmpty.

	aSpace := self newUnopenedTestingSpace.
	self assert: aSpace title equals: self asString.

	aSpace title: 'Initial Title'.
	self assert: aSpace title equals: 'Initial Title'.

	aSpace
		show;
		settle.
	self assert: aSpace title equals: 'Initial Title'.

	aSpace title: 'Updated Title'.
	self assert: aSpace title equals: 'Updated Title'
]

{ #category : #tests }
BlSpaceTest >> testToFront [

	| aSpace |
	aSpace := self newTestingSpace.
	self assert: aSpace isOpened.

	aSpace toFront.
	self assert: aSpace isOpened
]
