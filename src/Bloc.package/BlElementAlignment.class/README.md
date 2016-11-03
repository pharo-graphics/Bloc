I represent alignment layout property.

I calculate needed horizontal and vertical translation of BlElement to be aligned to the left, middle or to the right within allowed bounds.

I may be used by layout strategies that support alignment, for example Frame Layout

Public API and Key Messages

- horizontalTranslationFor: elementBounds in: allowedBounds calculate horizontal translation
- verticalTranslationFor: elementBounds in: allowedBounds calculate vertical translation
- #new to create instances.
 
Internal Representation and Key Implementation Points.
both element and allowed bounds should be in element's parent coordinate system