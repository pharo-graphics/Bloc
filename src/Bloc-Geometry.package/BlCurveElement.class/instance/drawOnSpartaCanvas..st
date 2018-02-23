drawing
drawOnSpartaCanvas: aCanvas

	aCanvas layer
		when: [ self hasHeads ]
		during: [
			| aBorder |

			aBorder := self border.
			aCanvas stroke
				alpha: self border opacity;
				paint: aBorder paint;
				path: (self geometry pathOnSpartaCanvas: aCanvas);
				width: aBorder width;
				in: [ :aPainter | aBorder style applyOn: aPainter ];
				draw.
			self drawArrowHeadsOnSpartaCanvas: aCanvas ]