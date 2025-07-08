Class {
	#name : #BlIgnoredLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #'examples - alignment' }
BlIgnoredLayoutTest >> testAlignmentIsStable [

	<sampleInstance>
	<demo>
	| aContainer aChild |
	aChild := BlElement new
		          extent: 50 @ 50;
		          background: (Color red alpha: 0.5);
		          constraintsDo: [ :c |
			          c ignoreByLayout.
			          c ignored vertical alignCenterAt: 0.
			          c ignored horizontal alignCenter ].

	aContainer := BlElement new
		              border: (BlBorder paint: Color black width: 1);
		              extent: 300 @ 200;
		              margin: (BlInsets top: 20);
		              clipChildren: false;
		              addChild: aChild.

	aContainer forceLayout.

	self assert: aContainer extent equals: 300 @ 200.
	self assert: aChild position equals: 125 @ -25.
	self assert: aChild extent equals: 50 @ 50.

	aChild requestLayout.
	aContainer forceLayout.

	self assert: aContainer extent equals: 300 @ 200.
	self assert: aChild position equals: 125 @ -25.
	self assert: aChild extent equals: 50 @ 50.

	^ aContainer
]
