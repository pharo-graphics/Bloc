BlChildrenArray is an optimized collection that manages the children array together with zArray and zReversedArray.
- zArray is the cache for the children ordered by z order, used during the picking (see: BlNode>>pickNode: ).
- zReversedArray is the cache for the reversed zArray, used during the drawing (see: BlElement>>drawOn:).