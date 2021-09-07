"
I am a helper class to ease text styling with the help of attributes.
Developers can add custom attributes by creating corresponding extension method on the instance side of `TBlTextStylable` trait.

```
| text styler |
text := 'Hi John' asRopedText.

styler := BlTextAttributesStyler on: (text from: 3 to: 7).
styler bold;
	italic;
	fontSize: 30;
	fontName: 'Roboto';
	monospace;
	foreground: Color darkGray.
styler style.

text
```

`BlText`provides fluent API that makes use of me:
```
| text |
text := 'Hi John' asRopedText.
(text from: 3 to: 7)
	stylerDo: [ :aStyler | aStyler bold italic foreground: Color red ].
text
```

"
Class {
	#name : 'BlTextAttributesStyler',
	#superclass : 'Object',
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'text',
		'properties'
	],
	#category : 'Bloc-Text-Text-Support'
}

{ #category : 'instance creation' }
BlTextAttributesStyler class >> on: aBlText [
	^ self new text: aBlText
]

{ #category : 'accessing' }
BlTextAttributesStyler >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ properties
]

{ #category : 'initialization' }
BlTextAttributesStyler >> initialize [
	super initialize.
	
	properties := BlTextAttributesBuilder new
]

{ #category : 'api - text style' }
BlTextAttributesStyler >> style [
	self attributesBuilder applyOn: self text
]

{ #category : 'accessing' }
BlTextAttributesStyler >> text [
	^ text
]

{ #category : 'accessing' }
BlTextAttributesStyler >> text: anObject [
	text := anObject
]
