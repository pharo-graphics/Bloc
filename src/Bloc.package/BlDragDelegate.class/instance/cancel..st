drag and drop
cancel: aPoint
	"Cancel drag and animate previews"	
	| aCancelAnimation |

	aCancelAnimation := BlParallelAnimation with: (self items collect: [ :aDragItem |
		| aPreviewBounds aSourceBounds aPreviewElement |
		aPreviewElement := aDragItem previewElement.
		
		aPreviewBounds := aPreviewElement bounds inSpace.
		aSourceBounds := aDragItem sourceElement bounds inSpace.
		
		BlNumberTransition new
			from: (aPreviewBounds position);
			to: (aSourceBounds center - (aPreviewBounds extent / 2.0));
			easing: (BlDecelerateInterpolator factor: 2);
			duration: 500 milliseconds;
			onStepDo: [ :aPosition | aPreviewElement relocate: aPosition ];
			onFinishedDo: [ aPreviewElement removeFromParent ].
	]).

	aCancelAnimation start