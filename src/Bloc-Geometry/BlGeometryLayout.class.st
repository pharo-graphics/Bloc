"
I am a special layout similar to frame layout that relies on geometry bounds instead of children when resizing mode is set to fit content.

Note, that I don't take element's padding into account when computing it's fitContent size.
"
Class {
	#name : #BlGeometryLayout,
	#superclass : #BlLayout,
	#category : 'Bloc-Geometry'
}

{ #category : #layout }
BlGeometryLayout >> layout: anElement in: aRectangle [
	| anElementTopLeft anElementBottomRight |
	
	anElementTopLeft := anElement insets topLeft.
	anElementBottomRight := anElement boundsInLocal corner - anElement insets bottomRight.

	self
		layeredChildren: anElement
		do: [ :aChild |
			| aMinTopLeft aChildBounds aChildOrigin aChildCorner aChildPosition |
			aMinTopLeft := anElementTopLeft + aChild outsets topLeft.
			
			aChildBounds := aChild measuredBounds asRectangle.
			aChildOrigin := aChildBounds origin max: aMinTopLeft.
			aChildCorner := aChildBounds corner min: anElementBottomRight - aChild outsets bottomRight.
			aChildPosition := (aChildCorner - aChildBounds extent) max: aMinTopLeft.		
			
			aChild applyLayoutIn: (aChildPosition extent: aChildBounds extent) ].
	
	self layoutIgnored: anElement
]

{ #category : #measure }
BlGeometryLayout >> measure: anElement with: anExtentSpec [
	| maxExtent maxWidth maxHeight |

	"By definition geometry layout relies on element's geometry bounds
	and does not take children into account.
	We can optimise children measurement and complete everything in just one pass"
	maxExtent := anElement geometryBounds extent.
	maxWidth := maxExtent x.
	maxHeight := maxExtent y.
	
	maxWidth := maxWidth.
	maxHeight := maxHeight.
	
	maxWidth := maxWidth min: anElement constraints maxWidth.
	maxHeight := maxHeight min: anElement constraints maxHeight.
	maxWidth := maxWidth max: anElement constraints minWidth.
	maxHeight := maxHeight max: anElement constraints minHeight.

	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ maxHeight).
	
	self measureChildren: anElement with: anExtentSpec
]

{ #category : #measure }
BlGeometryLayout >> measureChildren: anElement with: anExtentSpec [
	| availableWidth availableHeight |
	
	availableWidth := anElement measuredWidth - anElement insets width.
	availableHeight := anElement measuredHeight - anElement insets height.

	self
		measuredChildren: anElement
		do: [ :aChild |
			| childWidthSpec childHeightSpec |

			childWidthSpec := aChild constraints horizontal resizer isMatchParent
				ifTrue: [ 
					BlMeasurementSpec exact: ((availableWidth - aChild outsets width) max: 0) ]
				ifFalse: [ self
						measurementSpecFor: anExtentSpec widthSpec
						usedSize: anElement insets width + aChild outsets width
						resizer: aChild constraints horizontal resizer ].
			
			childHeightSpec := aChild constraints vertical resizer isMatchParent
				ifTrue: [ 
					BlMeasurementSpec exact: ((availableHeight - aChild outsets height) max: 0) ]
				ifFalse: [ self
						measurementSpecFor: anExtentSpec heightSpec
						usedSize: anElement insets height + aChild outsets height
						resizer: aChild constraints vertical resizer ].
		
				aChild measure: childWidthSpec @ childHeightSpec ]
]
