"
I export an element as a Form.

```
			
		
```

"
Class {
	#name : #BAFormExporter,
	#superclass : #BAExporter,
	#category : #'Bloc-Alexandrie-Exporter'
}

{ #category : #private }
BAFormExporter >> finishExport: aeCanvas [

	^ aeCanvas asForm
]

{ #category : #private }
BAFormExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]
