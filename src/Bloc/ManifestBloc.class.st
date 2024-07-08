"
Bloc is a **vector-based** low-level **graphical framework**. It builds on the **live** and **direct** principles from its Morphic cousin, but taking it to the next level, and above all: **clean**! 

One key property is that it relies on exactly one rendering tree at all times without the need of an intermediate canvas. This enables new kinds of visual interfaces, including a live and rich text editor and complicated visual scenes.
# Starting Points
Here are some of the most important classes to get a feel for how Bloc works.
## Key Classes with Helpful Comments
- `BlElement` - the class you will probably use the most
- `BlSpace` - a logical window

"
Class {
	#name : #ManifestBloc,
	#superclass : #PackageManifest,
	#category : #'Bloc-Manifest'
}

{ #category : #'code-critics' }
ManifestBloc class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BlRope #isNotEmpty #false)) #'2019-01-05T19:54:41.211552+01:00') )
]
