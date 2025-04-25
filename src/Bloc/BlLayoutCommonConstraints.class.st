"
I represent  layout constraints common to all layout.

I am responsible for storing and validating layout constraints. All my properties are meant to be immutable, so I always return an actual reference when requested.

I provide a way to support layout specific constraints with help of association layout class -> layout specific constraints. It is guaranteed that I can be used by any kind of layout.

I am used by BlElement and play a role of its layout constraints. Layouts referer to me in order to query layout constraints.

Public API and Key Messages

- at: return constraints specific for a layout
- margin return element's margin
- padding return element's padding

   BlCommonConstraints new
	maxHeight: 200;
	minWidth: 50
 
Internal Representation and Key Implementation Points.

    Instance Variables
	constraints:		<Dictionary>
	margin:			<BlInset>
	maxHeight:		<Number>
	maxWidth:		<Number>
	minHeight:		<Number>
	minWidth:		<Number>
	padding:		<BlInset>


    Implementation Points

"
Class {
	#name : #BlLayoutCommonConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'constraints',
		'position',
		'margin',
		'padding',
		'minHeight',
		'minWidth',
		'maxHeight',
		'maxWidth',
		'ignoredByLayout',
		'previouslyAccessedConstraints',
		'previouslyAccessedConstraintsType',
		'accountTransformation'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> accountByLayout [
	"Makes an element with this constraits be accounted by layout (not ignored)"

	ignoredByLayout := false
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> accountTransformation [
	"Let the layout know that the element's transformation should be taken into account during layout"
	
	accountTransformation := true
]

{ #category : #accessing }
BlLayoutCommonConstraints >> at: aLayoutClass [
	"Return a layout constrait object specific for a given layout defined by its class.
	Returned constraint can not be nil"
	<return: #BlLayoutConstraints>
	| aConstraints |
	
	"In most cases there is only one layout-specific constraint that is accessed extremely often.
	We can optimize lookup for this particular case by storing a type of previously accessed constraint"
	previouslyAccessedConstraintsType == aLayoutClass
		ifTrue: [ ^ previouslyAccessedConstraints ].
	
	constraints
		ifNil: [ constraints := Dictionary new ].

	aConstraints := constraints
		at: aLayoutClass
		ifAbsentPut: [ aLayoutClass constraints ].

	"Store the reference to the constraints and its type for optimization purpose described above"
	previouslyAccessedConstraints := aConstraints.
	previouslyAccessedConstraintsType := aLayoutClass.
	
	^ aConstraints
	
]

{ #category : #initialization }
BlLayoutCommonConstraints >> defaultHorizontal [
	^ BlLayoutCommonConstraintsAxis new
]

{ #category : #initialization }
BlLayoutCommonConstraints >> defaultVertical [
	^ BlLayoutCommonConstraintsAxis new
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> doNotAccountTransformation [
	"Let the layout know that the element's transformation should *not* be taken into account during layout"
	
	accountTransformation := false
]

{ #category : #testing }
BlLayoutCommonConstraints >> hasConstraintsForLayout: aLayoutClass [
	"Return true if a layout constrait object specific for a given 
	layout defined by its class has been created and stored "

	"In most cases there is only one layout-specific constraint that is accessed extremely often.
	We can optimize lookup for this particular case by storing a type of previously accessed constraint"

	previouslyAccessedConstraintsType == aLayoutClass ifTrue: [ ^ true ].
	^ constraints notNil and: [ constraints includesKey: aLayoutClass ]
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> ignoreByLayout [
	"Makes an element with this constraits be ignored by layout.
	An element will still be measured but will not be taken into account
	while measuring and laying out other elements"

	ignoredByLayout := true
]

{ #category : #'api - layouts' }
BlLayoutCommonConstraints >> ignored [
	^ self at: BlIgnoredLayout
]

{ #category : #testing }
BlLayoutCommonConstraints >> ignoredByLayout [
	"Return true if an element must be ignored by layout, otherwise false"
	<return: #Boolean>

	^ ignoredByLayout
]

{ #category : #initialization }
BlLayoutCommonConstraints >> initialize [
	super initialize.
	
	position := 0.0@0.0.
	
	margin := BlInsets empty.
	padding := BlInsets empty.

	maxHeight := Float infinity.
	maxWidth := Float infinity.
	minHeight := 0.0.
	minWidth := 0.0.
	
	ignoredByLayout := false.
	accountTransformation := false.
	
	"Initialzed lazily in at:"
	constraints := nil
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> margin [
	"Return an immutable margin property,
	margin can not be nil"
	<return: #BlInsets>
	^ margin
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> margin: aBlMargin [
	"Change element's margin to aBlMargin"
	
	margin := aBlMargin
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> maxHeight [
	"Return a maximal height an element can have,
	maxHeight can not be nil,
	maxHeight is always non-negative"
	<return: #Number>
	^ maxHeight
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> maxHeight: aNumber [
	"Set maximal height to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative (#isBlocPositive)"
	
	maxHeight := aNumber asFloat
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> maxSize: aPoint [
		
	self maxWidth: aPoint x asFloat.
	self maxHeight: aPoint y asFloat
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> maxWidth [
	"Return a maximal width an element can have,
	maxWidth can not be nil,
	maxWidth is always non-negative"
	<return: #Number>
	^ maxWidth
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> maxWidth: aNumber [
	"Set maximal width to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative (#isBlocPositive)"
	
	maxWidth := aNumber asFloat
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> minHeight [
	"Return a minimal height an element can have,
	minHeight can not be nil or infinity"
	<return: #Number>
	^ minHeight
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> minHeight: aNumber [
	"Set minimal height to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative (#isBlocPositive)"
	
	minHeight := aNumber asFloat
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> minSize: aPoint [
		
	self minWidth: aPoint x asFloat.
	self minHeight: aPoint y asFloat
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> minWidth [
	"Return a minimal width an element can have,
	minWidth can not be nil or infinity"
	<return: #Number>
	^ minWidth
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> minWidth: aNumber [
	"Set minimal width to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative (#isBlocPositive)"
		
	minWidth := aNumber asFloat
]

{ #category : #accessing }
BlLayoutCommonConstraints >> other [
	^ constraints ifNil: [ ^ Dictionary new ]
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> padding [
	"Return an immutable padding property.
	The padding can not be nil"
	<return: #BlInsets>

	^ padding
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> padding: aBlPadding [
	"Change element's padding."
	
	padding := aBlPadding
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> position [
	<return: #Point>

	^ position
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> position: aPoint [
	position := aPoint
]

{ #category : #'api - layouts' }
BlLayoutCommonConstraints >> requestedHeightIn: anElement [

	^ self vertical requestedHeightIn: anElement 
]

{ #category : #'api - layouts' }
BlLayoutCommonConstraints >> requestedSizeIn: anElement [

	^ (self requestedWidthIn: anElement) @ (self requestedHeightIn: anElement)
]

{ #category : #'api - layouts' }
BlLayoutCommonConstraints >> requestedWidthIn: anElement [

	^ self horizontal requestedWidthIn: anElement 
]

{ #category : #testing }
BlLayoutCommonConstraints >> shouldAccountTransformation [
	<return: #Boolean>

	^ accountTransformation
]
