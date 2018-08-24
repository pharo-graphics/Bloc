"
I am a body of a very fat chicken
"
Class {
	#name : #BlChickenBody,
	#superclass : #BlElement,
	#category : 'Bloc-Examples-Showcase-Chicken'
}

{ #category : #examples }
BlChickenBody class >> body [
	<gtExample>
	
	^ self new size: 200@300
]

{ #category : #initialization }
BlChickenBody >> defaultBackground [
	^ BlRadialGradientPaint new
		stops: { 
			0 -> Color yellow .
			1 -> Color orange };
		radius: 200;
		center: 100@100
]

{ #category : #initialization }
BlChickenBody >> defaultBorder [
	^ BlBorder paint: Color brown lighter width: 1
]

{ #category : #initialization }
BlChickenBody >> defaultGeometry [
	^ BlEllipse new
]
