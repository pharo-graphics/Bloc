Class {
	#name : #BlFrameLayoutConstraintTest,
	#superclass : #BlSpaceTestCase,
	#instVars : [
		'child',
		'parent'
	],
	#category : #'Bloc-Layout-Tests'
}

{ #category : #running }
BlFrameLayoutConstraintTest >> setUp [

	super setUp.

	parent := BlElement new
		          background: Color lightGreen;
		          extent: 100 @ 100;
		          layout: BlFrameLayout new;
		          position: 100 @ 100;
		          clipChildren: false.

	child := BlElement new
		         background: Color lightRed;
		         extent: 20 @ 20.

	parent addChild: child.

	space root addChild: parent
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft0Bottom0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 0.
			c frame vertical alignBottomAt: 0 ] ].
	self assert: child position equals: 0 @ 80
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft0Bottom1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 0.
			c frame vertical alignBottomAt: 1 ] ].
	self assert: child position equals: 0 @ -20
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft0Top0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 0.
			c frame vertical alignTopAt: 0 ] ].
	self assert: child position equals: 0 @ 0
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft0Top1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 0.
			c frame vertical alignTopAt: 1 ] ].
	self assert: child position equals: 0 @ 100
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft1Bottom0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 1.
			c frame vertical alignBottomAt: 0 ] ].
	self assert: child position equals: 100 @ 80
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft1Bottom1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 1.
			c frame vertical alignBottomAt: 1 ] ].
	self assert: child position equals: 100 @ -20
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft1Top0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 1.
			c frame vertical alignTopAt: 0 ] ].
	self assert: child position equals: 100 @ 0
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignLeft1Top1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignLeftAt: 1.
			c frame vertical alignTopAt: 1 ] ].
	self assert: child position equals: 100 @ 100
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight0Bottom0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 0.
			c frame vertical alignBottomAt: 0 ] ].
	self assert: child position equals: 80 @ 80
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight0Bottom1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 0.
			c frame vertical alignBottomAt: 1 ] ].
	self assert: child position equals: 80 @ -20
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight0Top0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 0.
			c frame vertical alignTopAt: 0 ] ].
	self assert: child position equals: 80 @ 0
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight0Top1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 0.
			c frame vertical alignTopAt: 1 ] ].
	self assert: child position equals: 80 @ 100
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight1Bottom0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 1.
			c frame vertical alignBottomAt: 0 ] ].
	self assert: child position equals: -20 @ 80
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight1Bottom1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 1.
			c frame vertical alignBottomAt: 1 ] ].
	self assert: child position equals: -20 @ -20
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight1Top0 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 1.
			c frame vertical alignTopAt: 0 ] ].
	self assert: child position equals: -20 @ 0
]

{ #category : #tests }
BlFrameLayoutConstraintTest >> testChildAlignRight1Top1 [

	space deferAndSettle: [
		child constraintsDo: [ :c |
			c frame horizontal alignRightAt: 1.
			c frame vertical alignTopAt: 1 ] ].
	self assert: child position equals: -20 @ 100
]
