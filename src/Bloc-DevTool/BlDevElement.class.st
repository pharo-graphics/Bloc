Class {
	#name : #BlDevElement,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #drawing }
BlDevElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
	| aWidth |

	aWidth := (self globalBoundsToLocal: (BlBounds origin: 0@0 extent: 1@1)) width.

	aCanvas stroke
		path: self geometryBounds;
		paint: (Color red alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw.

	aCanvas stroke
		path: self visualBounds;
		paint: (Color blue alpha: 0.5);
		width: aWidth;
		draw.
		
	aCanvas stroke
		path: self bounds inLocal asRectangle;
		paint: (Color gray alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw
]

{ #category : #drawing }
BlDevElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	self drawDebugInfoOnSpartaCanvas: aCanvas
]

{ #category : #'geometry bounds' }
BlDevElement >> invalidationBounds: aBounds [
	"I compute and load damaged area in my local coordinates that would be invalidated
	if #invalidate would be sent to me"
	<return: #BlBounds>
	| anInvalidationBounds |

	anInvalidationBounds := super invalidationBounds: aBounds.
	
	"in order to support debug drawing"
	anInvalidationBounds expandBy: 1.
	
	^ anInvalidationBounds
]
