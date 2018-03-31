I'm an element which is supposed to contain huge amount of children and layout only those of them that are visible inside my viewport.
I work with DataSources to fetch data from and can present data within different Infinite Layouts.

I fire the following events:
   - BlInfiniteChildDetachedEvent when a child element is detached

My main collaborators are:
 - BlInfiniteHolder
 - BlInfiniteLayout
 - BlInfiniteRecycler
 - BlInfiniteState