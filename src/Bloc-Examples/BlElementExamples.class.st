Class {
	#name : #BlElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'instance creation' }
BlElementExamples >> colorfulElement [
	<gtExample>
	| anElement |

	anElement := BlElement new.
	anElement size: 100@75.
	anElement background: ((BlLinearGradientPaint direction: 1@1) from: Color red to: Color blue).
	anElement border: (BlBorder paint: ((BlLinearGradientPaint direction: 1@1) matchExtent: 100@75; from: Color blue to: Color red) width: 5).
	anElement geometry: (BlRectangle cornerRadius: 20).

	^ anElement
]

{ #category : #'examples - opacity' }
BlElementExamples >> defaultOpacity [
	<gtExample>
	| anElement |

	anElement := self colorfulElement.

	self assert: anElement opacity equals: 1.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque. 
	
	^ anElement
]

{ #category : #'examples - opacity' }
BlElementExamples >> makeOpaque [
	<gtExample>
	| anElement |

	anElement := self colorfulElement.
	anElement opacity: 1.

	self assert: anElement opacity equals: 1.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque. 
	
	^ anElement
]

{ #category : #'examples - opacity' }
BlElementExamples >> makeTranslucent [
	<gtExample>
	| anElement |

	anElement := self colorfulElement.
	anElement opacity: 0.5.

	self assert: anElement opacity equals: 0.5.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent.
	self assert: anElement isOpaque not.
	
	^ anElement
]

{ #category : #'examples - opacity' }
BlElementExamples >> makeTransparent [
	<gtExample>
	| anElement |

	anElement := self colorfulElement.
	anElement opacity: 0.

	self assert: anElement opacity equals: 0.
	self assert: anElement isTransparent.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque not.
	
	^ anElement
]
