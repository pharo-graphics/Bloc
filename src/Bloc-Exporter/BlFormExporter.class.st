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

{ #category : #'instance creation' }
BlFormExporter >> createCanvas: anExtent [

	^ AeCanvas extent: anExtent
]

{ #category : #'api - exporting' }
BlFormExporter >> export [
	"Answer a Form"

	^ self doExport: [ :aCanvas | aCanvas asForm ]
]
