#  Read Only State API's

Files in this directory are Singleton (Classes) that SUBSCRIBE to data state changes in the store

And they use those state-change notifications to calculate more complex current state attributes

And expose a simple read-only API to the VC's/views

So the views can get the data they need without their own complex transformations against
the data they are passed from their own (if they implement) store subscriptions

In other words, the store-subscriptions at the view-level are COURSE and I don't want a bunch of complex
code in our VC's trying to reduce/distill that course/big state, to figure out current data state of individual teams, games, prices, etc

So these read-only API's will give them clean answers 

The only problem I need to work out is how to allow views to subscribe to THESE classes
instead of the store such that the view does not receive a state-change callback
BEFORE these singletons are updated



