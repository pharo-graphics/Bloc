# History

Bloc is a long term project for revamping the Pharo graphical interface.

The project was originally started by Alain Plantec from the Université de Bretagne Occidentale in collaboration with Stéphane Ducasse from RMOD/Inria. Bloc is the follow up of the Miro and Miro2 prototypes developed by Alain Plantec. Glenn Cavarle, at the time a PhD of Alain at Université de Bretagne Occidentale, was also a contributor. The work was also based on previous work of Igor Stasenko on the Athens canvas, OSWindow (made by Ronie Salgado and Igor Stasenko) and txText (a first cut at a new text editor). The work of Alain Plantec was paid by the University of Bretagne Occidental, while the work of Igor Stasenko by the RMOD Inria team.  

Here is an early video of Bloc (circa 2014): https://vimeo.com/115336678. Here is a presentation given at ESUG http://sdmeta.gforge.inria.fr/YouTubeVideos/PharoPreview/BlocSlides-ESUG2015.pdf

The first public demo was given by Alain Plantec in 2015 at the University of Bern. This is when Aliaksei (Alex) Syrel and Tudor Girba also joined the effort by starting to develop Brick (the widget layer on top of Bloc).

During 2015 and 2016, Bloc underwent 4 significant rewrites due to several reasons. To name a few:
- One consideration was obtaining a single tree of visual objects that define the entire scene (i.e., without shape objects).
- Other considerations were related to obtaining a strong event handling and layouting system.
- Animation and effect support was another one.
- And yet another one was having a performant yet flexible rendering.

All this lead to the design of the current version that is primarily based on the code produced by Glenn and Alex.

In the process, the project was split along three main components:
- Sparta is the underlying rendering canvas, currently supporting two backends: Morphic+Cairo and SDL2+Moz2D.
- Bloc is the core user interface framework, including low level code.
- Brick is the widget layer.

Then, Sparta-Skia was introduced by feencom and it became the first backend option.

In 2021, we started to work on a Bloc version that to be included in the future in Pharo.
This codebase started to retrofit a part of the development made at feenkcom, to focus on core features and stability.

In 2022, we introduced Alexandrie, a replacement of Sparta that uses Cairo much more efficiently and doesn't need the complexity of the bindings to Skia.