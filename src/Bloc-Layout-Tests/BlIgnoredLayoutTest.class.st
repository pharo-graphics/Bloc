Class {
	#name : 'BlIgnoredLayoutTest',
	#superclass : 'TestCase',
	#instVars : [
		'space'
	],
	#category : 'Bloc-Layout-Tests',
	#package : 'Bloc-Layout-Tests'
}

{ #category : 'running' }
BlIgnoredLayoutTest >> setUp [
	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost new.
	space show; waitPendingWork
]

{ #category : 'running' }
BlIgnoredLayoutTest >> tearDown [
	space ifNotNil: [
		space close; waitPendingWork.
		space := nil ].
	super tearDown
]

{ #category : 'tests' }
BlIgnoredLayoutTest >> testAlignmentIsStable [

	| aContainer aChild |
	aChild :=
		BlElement new
			extent: 50 @ 50;
			background: (Color red alpha: 0.5);
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored vertical alignCenterAt: 0.
				c ignored horizontal alignCenter ];
			yourself.

	aContainer :=
		BlElement new
			border: (BlBorder paint: Color black width: 1);
			extent: 300 @ 200;
			margin: (BlInsets top: 20);
			clipChildren: false;
			addChild: aChild;
			yourself.

	space mutateSync: [ space root addChild: aContainer ].

	self assert: aContainer extent equals: 300 @ 200.
	self assert: aChild position equals: 125 @ -25.
	self assert: aChild extent equals: 50 @ 50.

	space mutateSync: [ aChild requestLayout ].

	self assert: aContainer extent equals: 300 @ 200.
	self assert: aChild position equals: 125 @ -25.
	self assert: aChild extent equals: 50 @ 50
]
