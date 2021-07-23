"
Bloc is a **vector-based** low-level **graphical framework**. It builds on the **live** and **direct** principles from its Morphic cousin, but taking it to the next level, and above all: **clean**! 

One key property is that it relies on exactly one rendering tree at all times without the need of an intermediate canvas. This enables new kinds of visual interfaces, including a live and rich text editor and complicated visual scenes. Read more about this [here](https://medium.com/feenk/one-rendering-tree-918eae49bcff).
# Starting Points
Here are some of the most important classes to get a feel for how Bloc works.
## Key Classes with Helpful Comments
- {{gtClass:BlElement}} - the class you will probably use the most
- {{gtClass:BlUniverse}} - Bloc's ""foundation"" which interacts with the underlying {{gtClass:BlHost|label=host}} system
- {{gtClass:BlSpace}} - a logical window
  - {{gtClass:BlTime}} - while time is internal to space, it is cool enough to mention here :)
- {{gtClass:BrStencil}} - an element factory
# History
Bloc is inspired by the many lessons learned as Smalltalk has evolved through MVC, Morphic and others. It also incorporates many great ideas ""from the outside world"" (e.g. MVP, research papers). 

The project was initially started by Alain Plantec and Stéphane Ducasse as a Morphic replacement for [Pharo](https://pharo.org). Glenn Cavarle was also a major contributor until 2017. 

Most recently, [feenk](https://feenk.com) has put in a ton of work, bringing the broader ambition of offering a live environment that would enable a new kind of user interfaces. Aliaksei Syrel and Tudor Girba joined the project around 2015, and other team members followed. Excitingly, they've taken the bold step of ""eating their own dog food"" by putting it into production as the UI for their flagship [GToolkit](https://gtoolkit.com) platform. 

"
Class {
	#name : 'ManifestBloc',
	#superclass : 'PackageManifest',
	#category : 'Bloc-Manifest'
}

{ #category : 'code-critics' }
ManifestBloc class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BlRope #isNotEmpty #false)) #'2019-01-05T19:54:41.211552+01:00') )
]
