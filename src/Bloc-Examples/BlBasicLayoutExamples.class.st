Class {
	#name : #BlBasicLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'instance creation' }
BlBasicLayoutExamples >> parentWithChildExactSize [
	<gtExample>
	| child parent |

	child := BlElement new.
	child layout: BlBasicLayout new.
	child background: (Color red alpha: 0.3).
	child border: (BlBorder paint: Color red width: 1).
	child constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical exact: 100 ].

	parent := BlElement new.
	parent layout: BlBasicLayout new.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 300 ].
	parent addChild: child.
	parent forceLayout.

	self assert: parent extent equals: (300@300).
	self assert: child extent equals: (100@100).

	^ parent
]

{ #category : #'instance creation' }
BlBasicLayoutExamples >> parentWithChildFitContent [
	<gtExample>
	| child parent |

	parent := self parentWithChildExactSize.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal fitContent .
		c vertical fitContent ].

	parent forceLayout.

	self assert: parent extent equals: (300@300).
	self assert: child extent equals: (0@0).

	^ parent
]

{ #category : #'instance creation' }
BlBasicLayoutExamples >> parentWithChildMatchParent [
	<gtExample>
	| child parent |

	parent := self parentWithChildExactSize.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal matchParent .
		c vertical matchParent ].

	parent forceLayout.

	self assert: parent extent equals: (300@300).
	self assert: child extent equals: (300@300).

	^ parent
]
