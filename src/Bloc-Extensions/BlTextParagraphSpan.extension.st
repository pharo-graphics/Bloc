Extension { #name : #BlTextParagraphSpan }

{ #category : #'*Bloc-Extensions' }
BlTextParagraphSpan >> gtPositionsAtIndicesFor: aView [
	<gtView>
	
	^ aView sparta
		title: 'Positions';
		priority: 10;
		matchParent;
		rendering: [ :aCanvas :anElement |
			| aScale |
			
			aScale := (aCanvas extent min / self extent max) * 0.9.
			
			aCanvas transform
				by: [ :t |
					t scaleBy: aScale.
					t translateBy: (0@self top negated) + 2 ]
				during: [
					aCanvas transform
						by: [ :t | t translateBy: self baseline negated ]
						during: [ self drawOnSpartaCanvas: aCanvas ].
					0 to: self spanLength do: [ :eachIndex |
						| aPosition |
						
						aPosition := self positionAt: eachIndex.
						aCanvas stroke
							path: (aCanvas shape line: aPosition x @ self top to: aPosition x @ (self top + self height));
							width: 1.0 / aScale;
							paint: (Color black alpha: 0.5);
							draw.
							
						aCanvas stroke
							path: (self bounds);
							width: 1.0 / aScale;
							paint: (Color black alpha: 0.5);
							draw
						
					] ]
		]
]
