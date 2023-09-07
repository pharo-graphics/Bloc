"
I export an element as a Form.

```
			
		
```

"
Class {
	#name : #BlFormExporter,
	#superclass : #BlExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #private }
BlFormExporter >> finishExport: aeCanvas [

	^ aeCanvas asForm
]

{ #category : #private }
BlFormExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]
