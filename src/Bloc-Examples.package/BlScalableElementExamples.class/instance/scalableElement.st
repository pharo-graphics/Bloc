examples - instance creation
scalableElement
	<gtExample>
	| aScalableElement |

	aScalableElement := BlScalableElement new.
	aScalableElement size: self scalableExtent.
	aScalableElement border: (BlBorder builder dashed width: 2; paint: Color gray; build).
	
	self assert: aScalableElement hasContentElement not.
	self assert: aScalableElement measureScale equals: 1.0.
	self assert: aScalableElement scaleStrategy equals: BlScalableFitAllStrategy new.

	^ aScalableElement