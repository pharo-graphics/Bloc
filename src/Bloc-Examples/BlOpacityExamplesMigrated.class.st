"
! Opacity

It is possible to change transparency of the element and all its children by setting the ==opacity== property. Opacity is represented by a float number within the closed interval [0...1].
""""NB: Opacity is a purely visual property, it is not taken into account during event dispatch phase, thus even transparent elements still receive mouse events""""

When opacity is set to 0 an element is considered to be fully transparent, thus ${method:BlElement>>#isTransparent}$ returns true:
${example:BlOpacityExamples>>#makeTransparent}$
If opacity is set to 1, the element is considered to be opaque, ${method:BlElement>>#isOpaque}$ returns true:
${example:BlOpacityExamples>>#makeOpaque}$
The last but not least state of transparency is when opacity property has a value between 0 and 1, but not equal to them. In this case we call the element translucent and ${method:BlElement>>#isTranslucent}$ returns true:
${example:BlOpacityExamples>>#makeTranslucent}$
In the following example we show how to change and query ==opacity== of the element:
[[[
|element|
element := BlElement new background: Color black.
element opacity: 0.5.
self assert: element opacity equals: 0.5.
element
]]]

"
Class {
	#name : #BlOpacityExamplesMigrated,
	#superclass : #Object,
	#category : #'Bloc-Examples-DocumentationMigrated'
}

{ #category : #'instance creation' }
BlOpacityExamplesMigrated >> colorfulElement [
	<gtExample>
	| anElement |

	anElement := BlElement new.
	anElement size: 100@75.
	anElement background: ((BlLinearGradientPaint direction: 1@1) from: Color red to: Color blue).
	anElement border: (BlBorder paint: ((BlLinearGradientPaint direction: 1@1) matchExtent: 100@75; from: Color blue to: Color red) width: 5).
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 20).

	^ anElement
]

{ #category : #'examples - opacity' }
BlOpacityExamplesMigrated >> defaultOpacity [
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
BlOpacityExamplesMigrated >> makeOpaque [
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
BlOpacityExamplesMigrated >> makeTranslucent [
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
BlOpacityExamplesMigrated >> makeTransparent [
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
