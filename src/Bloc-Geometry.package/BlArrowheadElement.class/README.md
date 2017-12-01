I am a root class for all arrowheads to be used with curve element.

I listen to border width changes of my parent in order to adapt geometry. That is why I am not intended to work outside of CurveElement context, however I can still be used for the case when arrow size depends on border width of a parent.

In order to have pixel perfect connection of the arrowhead with its curve I am treated differently than other children in CurveElement. I also provide custom draw logic to avoid usage of virual canvas layers that prevents the use of ==Source== composition operator.

