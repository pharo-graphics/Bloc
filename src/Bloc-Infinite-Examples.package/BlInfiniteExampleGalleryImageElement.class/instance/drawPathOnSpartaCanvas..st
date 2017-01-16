drawing
drawPathOnSpartaCanvas: aCanvas
	| aScale |
	super drawPathOnSpartaCanvas: aCanvas.
	
	form
		ifNil: [ ^ self ].
	
	aScale := (self extent / form extent) asFloatPoint.
	
	aScale ~= (1@1) ifTrue: [ 
		aCanvas transform
			push;
			scaleBy: aScale;
			apply ].
	
	aCanvas fill
		path: (0@0 extent: form extent);
		paint: form;
		draw.
		
	aScale ~= (1@1) ifTrue: [ 
		aCanvas transform pop ]