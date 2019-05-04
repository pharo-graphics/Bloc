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
		'margin',
		'padding',
		'minHeight',
		'minWidth',
		'maxHeight',
		'maxWidth',
		'ignoredByLayout',
		'previouslyAccessedConstraints',
		'previouslyAccessedConstraintsType'
	],
	#category : 'Bloc-Layouts-Basic'
}

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> accountByLayout [
	"Makes an element with this constraits be accounted by layout (not ignored)"

	ignoredByLayout := false
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
	
	margin := BlInsets empty.
	padding := BlInsets empty.

	maxHeight := Float infinity.
	maxWidth := Float infinity.
	minHeight := 0.
	minWidth := 0.
	
	ignoredByLayout := false.
	
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
	"Change element's margin to a BlMargin
	aBlMargin must not be nil"
	self
		assert: [ aBlMargin isNotNil ]
		description: [ 'Margin must not be nil' ].
	
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
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Maximal height must not be nil' ].
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Maximal height must be non-negative' ].
	
	maxHeight := aNumber
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
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Maximal width must not be nil' ].
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Maximal width must be non-negative' ].
	
	maxWidth := aNumber
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
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Minimal height must not be nil' ].
		
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Minimal height must not be infinite' ].
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Minimal height must be non-negative' ].
	
	minHeight := aNumber
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
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Minimal width must not be nil' ].
		
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Minimal width must not be infinite' ].
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Minimal width must be non-negative' ].
		
	minWidth := aNumber
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> padding [
	"Return an immutable padding property,
	margin can not be nil"
	<return: #BlInsets>

	^ padding
]

{ #category : #'api - constraints' }
BlLayoutCommonConstraints >> padding: aBlPadding [
	"Change element's margin to a BlMargin
	aBlPadding must not be nil"
	self
		assert: [ aBlPadding isNotNil ]
		description: [ 'Padding must not be nil' ].
	
	padding := aBlPadding
]
