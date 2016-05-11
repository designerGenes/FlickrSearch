# FlickrSearch
This app was written as a Proof of Concept coding test.  It allows users to retrieve a current and updateable list of photos from the Flickr public API.  Users may choose to either retrieve the most recent "Interesting" photos from Flickr, or search for the most recent photos associated with a user-provided tag.  As this app needed to be written in a very short amount of time, there is not yet any text quality checking on the "tag" that the user provides.

Pulling down from the top of the list refreshes the feed.  This process is very rudimentary so far, and works just by saving the query that the user has currently loaded, and initiating it once again.

Each photo also comes with the uploader's username and buddy icon, as well as the time distance between now and the picture's post date.

The "settings" button at the top is animated but not yet connected to its desired interface.  That will soon allow the user to specify date ranges for their query.

PLEASE NOTE: this app is very unfinished.  It exists only to prove a concept.  I chose to write it in Objective C as a personal challenge to myself, but if requested it can be rewritten easily in Swift 2.0 
