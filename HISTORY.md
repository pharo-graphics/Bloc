Bloc is a long term project for revamping the Pharo graphical interface.

The project was originally started by Alain Plantec from the Université de Bretagne Occidentale. Glenn Cavarle, at the time a PhD of Alain at Université de Bretagne Occidentale, was also a contributor. The work was also based on previous work of Igor Statsenko on the Athens canvas and on collaboration with Stephane Ducasse and the RMoD group from Inria Lille.

The first public demo was given by Alain Plantec in 2015 at the University of Bern. This is when Aliaksei (Alex) Syrel and Tudor Girba also joined the effort.

During 2015 and 2016, Bloc underwent 4 significant rewrites due to several reasons. To name a few:
- One consideration was obtaining a single tree of visual objects that define the entire scene (i.e., without shape objects).
- Other considerations were related to obtaining a strong event handling and layouting system.
- Animation and effect support was another one.
- And yet another one was having a performant yet flexible rendering.

All this lead to the design of the current version that is primarily based on the code produced by Glenn and Alex.

In the process, the project was split along three main components:
- Sparta is the underlying canvas that supports rendering based both on Morphic+Cairo and on SDL2+Moz2D.
- Bloc is the core user interface framework including low level .
- Brick is the widget layer.
