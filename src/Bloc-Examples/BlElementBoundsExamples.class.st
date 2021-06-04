"
I contain examples of element bounds api

"
Class {
	#name : #BlElementBoundsExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlElementBoundsExamples >> bounds [
	"Element bounds consist of position and extent"
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds asRectangle equals: (self childPosition extent: self childExtent).
	self assert: parent bounds asRectangle equals: (self parentPosition extent: self parentExtent).
	
	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInLocal [
	"Bounds in local always have position 0@0"
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal asRectangle equals: (0.0@0.0 extent: self childExtent).
	self assert: parent bounds inLocal asRectangle equals: (0.0@0.0 extent: self parentExtent).

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInLocalInLocal [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal inLocal asRectangle equals: (0@0 extent: self childExtent).
	self assert: parent bounds inLocal inLocal asRectangle equals: (0@0 extent: self parentExtent).

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInLocalInParent [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal inParent asRectangle equals: (self childPosition extent: self childExtent).
	self assert: child bounds inLocal inParent referenceElement equals: child.

	self assert: parent bounds inLocal inParent asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inLocal inParent referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInLocalInSpace [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal inSpace asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inLocal inSpace referenceElement equals: child.

	self assert: parent bounds inLocal inSpace asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inLocal inSpace referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInParent [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inParent asRectangle equals: (self childPosition extent: self childExtent).
	self assert: child bounds inParent referenceElement equals: child.

	self assert: parent bounds inParent asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInParentInLocal [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inParent inLocal asRectangle equals: (self childPosition extent: self childExtent).
	self assert: child bounds inParent inLocal referenceElement equals: child.

	self assert: parent bounds inParent inLocal asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent inLocal referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInParentInParent [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self
		assert: child bounds inParent inParent asRectangle
		equals: ((self childPosition + self parentPosition) extent: self childExtent).
	self assert: child bounds inParent inParent referenceElement equals: parent.

	self
		assert: parent bounds inParent inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent inParent referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInParentInParentInParent [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self
		assert: child bounds inParent inParent inParent asRectangle
		equals: ((self childPosition + self parentPosition) extent: self childExtent).
	self assert: child bounds inParent inParent inParent referenceElement equals: parent.

	self
		assert: parent bounds inParent inParent inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent inParent inParent referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpace [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace referenceElement equals: child.

	self assert: parent bounds inSpace asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpaceInLocal [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace inLocal asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace inLocal referenceElement equals: child.

	self assert: parent bounds inSpace inLocal asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace inLocal referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpaceInParent [
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace inParent asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace inParent referenceElement equals: child.

	self assert: parent bounds inSpace inParent asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace inParent referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpecificChild [
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"(child bounds inChild: child) === (child bounds inLocal)"
	self assert: (child bounds inChild: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: (child bounds inChild: child) referenceElement equals: child.
	
	self assert: (parent bounds inChild: child) asRectangle equals: (self childPosition negated extent: self parentExtent).
	self assert: (parent bounds inChild: child) referenceElement equals: child.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpecificChildInSpecificParent [
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inChild: child) inParent: child) === (child bounds inLocal)"
	self assert: ((child bounds inChild: child) inParent: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: ((child bounds inChild: child) inParent: child) referenceElement equals: child.

	"((parent bounds inChild: child) inParent: parent) === (parent bounds)"
	self assert: ((parent bounds inChild: child) inParent: parent) asRectangle equals: (0@0 extent: self parentExtent).
	
	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self assert: ((parent bounds inChild: child) inParent: parent) referenceElement equals: child.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpecificParent [
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	self assert: (child bounds inParent: parent) asRectangle equals: (self childPosition extent: self childExtent).
	self assert: (child bounds inParent: parent) referenceElement equals: child.

	"(parent bounds inParent: parent) === (parent bounds inLocal)"
	self assert: (parent bounds inParent: parent) asRectangle equals: (0@0 extent: self parentExtent).
	self assert: (parent bounds inParent: parent) referenceElement equals: parent.

	^ parent
]

{ #category : #examples }
BlElementBoundsExamples >> boundsInSpecificParentInSpecificChild [
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inParent: parent) inChild: child) === (child bounds inLocal)"
	self assert: ((child bounds inParent: parent) inChild: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: ((child bounds inParent: parent) inChild: child) referenceElement equals: child.

	"((parent bounds inParent: parent) inChild: parent) === (parent bounds inLocal)"
	self assert: ((parent bounds inParent: parent) inChild: parent) asRectangle equals: (0@0 extent: self parentExtent).
	
	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self assert: ((parent bounds inParent: parent) inChild: parent) referenceElement equals: parent.

	^ parent
]

{ #category : #'instance creation' }
BlElementBoundsExamples >> child [
	<gtExample>
	
	^ BlElement new
		size: self childExtent;
		relocate: self childPosition;
		background: Color red
]

{ #category : #config }
BlElementBoundsExamples >> childExtent [
	^ 100@50
]

{ #category : #config }
BlElementBoundsExamples >> childPosition [
	^ 200@150
]

{ #category : #'instance creation' }
BlElementBoundsExamples >> parent [
	<gtExample>
	
	^ BlElement new
		size: self parentExtent;
		relocate: self parentPosition;
		background: (Color gray alpha: 0.3)
]

{ #category : #config }
BlElementBoundsExamples >> parentExtent [
	^ 500@400
]

{ #category : #config }
BlElementBoundsExamples >> parentPosition [
	^ 100@75
]

{ #category : #'instance creation' }
BlElementBoundsExamples >> parentWithChild [
	<gtExample>
	
	^ self parent
		addChild: self child;
		forceLayout
]

{ #category : #'examples - special' }
BlElementBoundsExamples >> shadowEffectBoundsWithoutOffset [
	<gtExample>
	| parent child shadowWidth |

	shadowWidth := 20.

	parent := self parentWithChild.
	child := parent children first.
	child effect: (BlGaussianShadowEffect color: Color black width: shadowWidth offset: 0@0).

	self assert: child effectBounds equals: (shadowWidth * 3 asPoint negated corner: self childExtent + (shadowWidth * 3 asPoint)).

	child size: self childExtent * 2.
	child forceLayout.

	self assert: child effectBounds equals: (shadowWidth * 3 asPoint negated corner: (self childExtent * 2) + (shadowWidth * 3 asPoint)).

	^ parent
]
