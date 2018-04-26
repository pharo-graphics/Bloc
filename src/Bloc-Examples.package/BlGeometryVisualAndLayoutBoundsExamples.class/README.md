! Geometry, Visual, and Layout Bounds Explained

A bound is a territorial limit, a boundary. In terms of a graphical element, it is a space in which the graphical element is rendered. For simplicity, bounds are rectangular areas.

!! Layout Bounds

In the following example, the layout bound of the triangle is defined by a green rectangle:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#clippedTriangle|height=150|expanded=true|noCode=true|show=gtLiveIn:]]]

Layout bounds are considered by layout algorithms to define mutual locations for all considered elements. 

!! Visual Bounds

As you may noticed in the example above, the triangle is not fully visible. It is an intention to explain what is a visual bound. Let's consider the following example where the triangle exceeds the layout bound:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#fullyVisibleTriangle|height=170|expanded=true|noCode=true|show=gtLiveIn:]]]

A visual bound is the most precise area occupied by a graphical element. In our case, by the triangle. Computing visual bounds is the most expensive computation as it takes strokes and rendering into account. The blue rectangle defines the visual bounds:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#debuggingMode|height=180|expanded=true|noCode=true|show=gtLiveIn:]]]

!! Geometry Bounds 

The example above shows also gemoetry bounds in red. TODO: Why it is inside of the green rectangle? Is it literally the same as layout bounds? Maybe we do not need to define one of them? 

blue is visual bounds and red is geometry bounds.
Visual bounds is the most precise thing, while geometry bounds is basically layout (position + extent)

! Debugging Bounds

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#misalignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

As you can see in the code `BlLinearLayout horizontal alignCenter`, it might not be clear why the icon and text are not vertically centered.

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#debuggingMisalignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

TODO: I am confused... it does not show what I expected (as halo). 
