"
I am a chicken hed with eyes and pecker
"
Class {
	#name : #BlChickenHead,
	#superclass : #BlElement,
	#category : #'Bloc-Examples-Showcase-Chicken'
}

{ #category : #examples }
BlChickenHead class >> head [
	<gtExample>
	
	^ self new size: 200@200
]

{ #category : #initialization }
BlChickenHead >> defaultBackground [
	^ Color yellow
]

{ #category : #initialization }
BlChickenHead >> defaultBorder [
	^ BlBorder paint: Color brown width: 1
]

{ #category : #initialization }
BlChickenHead >> defaultGeometry [
	^ BlEllipse new
]

{ #category : #drawing }
BlChickenHead >> drawOnSpartaCanvas: aCanvas [
	| anEye |
	super drawOnSpartaCanvas: aCanvas.
	
	anEye := aCanvas shape circleAt: 0@0 radius: self extent min / 8.0.
	
	aCanvas transform
		translateBy: (self width / 4.0) @ (self height / 3.0);
		push.
	
	aCanvas fill
		paint: Color white;
		path: anEye;
		draw;
		paint: Color black;
		path: (aCanvas shape circleAt: (self extent min / 32.0)  @ 0  radius: self extent min / 16.0);
		draw.
		
	aCanvas stroke
		paint: Color brown;
		path: anEye;
		width: 1;
		draw.
		
	aCanvas transform
		translateBy: (self width / 2.0) @ 0;
		push.
	
	aCanvas fill
		paint: Color white;
		path: anEye;
		draw;
		paint: Color black;
		path: (aCanvas shape circleAt: (self extent min / 32.0) negated @ 0  radius: self extent min / 16.0);
		draw.

	aCanvas stroke
		paint: Color brown;
		path: anEye;
		width: 1;
		draw.
	
	aCanvas transform
		translateBy: (self width / 4.0) negated @ (self height / 4.0);
		push.

	aCanvas fill
		path: (aCanvas path
			relative;
			moveTo: self width / -16.0 @ 0;
			lineTo: self width / 16.0 @ (self height / 2.0);
			lineTo: self width / 16.0 @ (self height / -2.0);
			lineTo: self width / 16.0 negated @ 0;
			close;
			finish);
		paint: Color red;
		draw.
	
	aCanvas transform pop pop pop.
		
]
