"
I am a special element whose rendering can be customized.

```
element := BlSpartaElement new.
element rendering: [ :aCanvas :anElement |
	aCanvas fill
		paint: Color red;
		path: anElement bounds asRectangle;
		draw ].
element
```

"
Class {
	#name : #BlSpartaElement,
	#superclass : #BlElement,
	#instVars : [
		'renderingStrategy'
	],
	#category : #'Bloc-Sparta'
}

{ #category : #drawing }
BlSpartaElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.
	
	renderingStrategy glamourValueWithArgs: { aCanvas . self }
]

{ #category : #initialization }
BlSpartaElement >> initialize [
	super initialize.
	
	renderingStrategy := [ :aSpartaCanvas :anElement | ]
]

{ #category : #accessing }
BlSpartaElement >> rendering: aValuable [
	renderingStrategy := aValuable
]
