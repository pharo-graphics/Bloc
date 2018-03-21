private
doExport: aFinalizingBlock
	| aCanvas aBoundsInParent anElement |

	anElement := self element.
	anElement forceLayout.

	aBoundsInParent := self computeBounds.
	
	aCanvas := self createCanvas: (aBoundsInParent extent max: 1@1).
	
	self
		drawOn: aCanvas
		during: [
			aCanvas transform during: [ :aTransform |
				aTransform
				translateBy: (aBoundsInParent origin) negated;
				apply.

			anElement fullDrawOnSpartaCanvas: aCanvas ] ].
	
	^ aFinalizingBlock cull: aCanvas