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
	^ Bloc preferableSpartaCanvas extent: anExtent
]

{ #category : #'api - exporting' }
BlFormExporter >> export [
	<return: #Form>

	^ self doExport: [ :aCanvas | aCanvas asForm ]
]
