"
! Frame layout

I am a layout designed to block out an area on the screen to display a single child. 

I should only be used to display a single child, as it can be difficult to display multiple children at different positions on the screen without overlapping each other. 
However, elements with a frame layout can have multiple child elements. The =='weight'== and =='alignment'== atributes can be used to control the position of children. However, weight only works when the child matches the parent; if it fits content or has an exact size, the weight attribute is ignored. I rely on custom layout constraints for setting  attributes (see ${class:BlFrameLayoutConstraints}$, ${class:BlFrameLayoutConstraintsHorizontal}$ and ${class:BlFrameLayoutConstraintsVertical}$).

I position each child element based on the top left of the screen. Child elements are stacked on top of each other, with the most recently added child on top. An important property is that the location of a child is independent from the location of other children. 

I am similar to the frame layout from Android. The main differences are that I:
- provide support for controlling the size of a child element using the =='weight'== attribute;
- the =='gravity'== attribute is not present; instead the =='alignment'== attribute should be used.

!! Alignment
You can add multiple children to a FrameLayout and control their position within the FrameLayout by assigning alignment to each child.

Example of a child in the bottom right corner:

[[[
| child parent |
child := BlElement new
	size: 200@200;
	constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ];
	border: (BlBorder paint: Color black width: 4);
	background: Color green.
		
parent := BlElement new
	layout: BlFrameLayout new;
	size: 350@350;
	padding: (BlInsets all: 10);
	background: Color blue;
	addChild: child.
]]]


!! Weight
Children that match parent can also be configured to occupy only a fraction of parent's size by providing a weight [0...N]
Example:

[[[
| child parent |
child := BlElement new.
child background: Color red.
child constraintsDo: [ :c |
	c horizontal matchParent.
	c vertical matchParent.
	c frame horizontal alignCenter; weight: 0.3.
	c frame vertical alignCenter; weight: 0.5 ].

parent := BlElement new.
parent layout: BlFrameLayout new.
parent size: 300@300.
parent background: (Color gray alpha: 0.5).
parent addChild: child.
parent
]]]
"
Class {
	#name : #BlFrameLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Frame'
}

{ #category : #constraints }
BlFrameLayout class >> constraints [
	^ BlFrameLayoutConstraints new
]

{ #category : #'api - alignment' }
BlFrameLayout >> align: aChildElement horizontal: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]
]

{ #category : #'api - alignment' }
BlFrameLayout >> align: aChildElement vertical: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]
]

{ #category : #layout }
BlFrameLayout >> layout: anElement in: aRectangle [
	| parentBounds |
	
	self layoutIgnored: anElement.
	
	"first store parent's local bounds"
	parentBounds := anElement padding inset: (0@0 extent: aRectangle extent).

	self
		layeredChildren: anElement
		do: [ :aChild |
			| childBounds alloowedBounds |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds bounds copy.
			alloowedBounds := aChild margin inset: parentBounds copy.
		
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := childBounds := self
				align: aChild
				bounds: childBounds
				in: alloowedBounds
				with: aChild constraints frame alignment.
			"and finally set new bounds"
			aChild applyLayoutIn: childBounds ].
]

{ #category : #measure }
BlFrameLayout >> measure: anElement with: anExtentSpec [
	| matchParentChildren |

	"First measure children that know their size (exact and fit content),
	collecting those that needs to be measured later after we know parent's size"
	matchParentChildren := self measureChildren: anElement with: anExtentSpec.
	"Second pass to measure children that match parent"
	self measureMatching: matchParentChildren of: anElement with: anExtentSpec
]

{ #category : #measure }
BlFrameLayout >> measureChild: aChildElement of: anElement with: anExtentSpec [
	| aParentHeight aParentWidth |

	aParentWidth := anExtentSpec widthSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ anExtentSpec widthSpec size ].
	aParentHeight := anExtentSpec heightSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ anExtentSpec heightSpec size ].

	self
		measureChild: aChildElement
		of: anElement
		with: anExtentSpec
		width: aParentWidth
		height: aParentHeight
]

{ #category : #measure }
BlFrameLayout >> measureChild: aChildElement of: anElement with: anExtentSpec width: aParentWidth height: aParentHeight [
	| childWidthMeasureSpec childHeightMeasureSpec |

	aChildElement constraints horizontal resizer isMatchParent
		ifTrue: [ 
			| weight width |
			weight := (aChildElement constraints frame horizontal weight max: 0).
			width := ((aParentWidth - anElement insets width - aChildElement outsets width) * weight) max: 0.
			childWidthMeasureSpec := BlMeasurementSpec exact: width ]
		ifFalse: [ 
			childWidthMeasureSpec := self
				measurementSpecFor: anExtentSpec widthSpec
				usedSize: anElement insets width + aChildElement outsets width
				resizer: aChildElement constraints horizontal resizer ].

	aChildElement constraints vertical resizer isMatchParent
		ifTrue: [ 
			| weight height |
			weight := (aChildElement constraints frame vertical weight max: 0).
			height := ((aParentHeight - anElement insets height - aChildElement outsets height) * weight) max: 0.
			childHeightMeasureSpec := BlMeasurementSpec exact: height ]
		ifFalse: [ 
			childHeightMeasureSpec := self
				measurementSpecFor: anExtentSpec heightSpec
				usedSize: anElement insets height + aChildElement outsets height
				resizer: aChildElement constraints vertical resizer ].

	aChildElement measure: childWidthMeasureSpec @ childHeightMeasureSpec
]

{ #category : #measure }
BlFrameLayout >> measureChildren: anElement with: anExtentSpec [
	"Perform a first measurement pass and measure those children for which we can
	determine an extent, otherwise add children to a collection that should be
	measured during second pass and return it"
	<return: #LinkedList of: #BlElement>
	| measureMatchParentChildren matchParentChildren maxHeight maxWidth |
	
	matchParentChildren := LinkedList new.
	
	"true if children matching parent should be measured in first pass"	
	measureMatchParentChildren := anExtentSpec isExact.

	maxWidth := 0.
	maxHeight := 0.

	self measureIgnored: anElement with: anExtentSpec.
	
	self
		measuredChildren: anElement
		do: [ :aChild |
			| shouldMeasureChild |
			
			"true if aChild should be measured NOW or false if it should happen during second measurement pass.
			we measure children if parent is exact or if child does not match parent"
			shouldMeasureChild := measureMatchParentChildren
				or: [ aChild constraints horizontal resizer isMatchParent not
					and: [ aChild constraints vertical resizer isMatchParent not ] ].
			shouldMeasureChild
				"measure now"
				ifTrue: [
					self measureChild: aChild of: anElement with: anExtentSpec.
					maxWidth := maxWidth max: (aChild measuredWidth + aChild outsets width).
					maxHeight := maxHeight max: (aChild measuredHeight + aChild outsets height) ]
				"or during second pass"
				ifFalse: [ matchParentChildren add: aChild ] ].
	
	maxWidth := maxWidth + anElement insets width.
	maxHeight := maxHeight + anElement insets height.

	maxWidth := maxWidth max: anElement constraints minWidth.
	maxHeight := maxHeight max: anElement constraints minHeight.
	
	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ maxHeight).
	
	^ matchParentChildren
]

{ #category : #measure }
BlFrameLayout >> measureMatching: theChildren of: anElement with: anExtentSpec [
	theChildren
		ifEmpty: [ ^ self ].

	theChildren do: [ :aChildElement |
		self measureMatchingChild: aChildElement of: anElement with: anExtentSpec ]
]

{ #category : #measure }
BlFrameLayout >> measureMatchingChild: aChildElement of: anElement with: anExtentSpec [

	self
		measureChild: aChildElement
		of: anElement
		with: anExtentSpec
		width: anElement measuredWidth
		height: anElement measuredHeight
]
