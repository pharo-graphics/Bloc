drawing
drawOnSpartaCanvas: aCanvas

	aCanvas layer
		when: [ self hasHeads ]
		during: [
			| aBorder |
			self drawArrowHeadsOnSpartaCanvas: aCanvas.

			aBorder := self border.
			aCanvas stroke
				alpha: self border opacity;
				paint: aBorder paint;
				path: (self pathCache geomPathOnSpartaCanvas: aCanvas);
				width: aBorder width;
				in: [ :aPainter | aBorder style applyOn: aPainter ];
				"we should draw curve where there are no heads"
				in: [ :aPainter | self hasHeads ifTrue: [ aPainter composeXor ] ];
				draw ]