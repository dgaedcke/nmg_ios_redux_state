#  Read Only State API's

Files in this directory are immutable structs that receive the main app state
(from the filter operation on a subscriber {normally a VC} )
And then calculate more complex current state attributes that is appropriate for the VC needs
(kind of like a view-mode)

They expose a simple read-only API to the VC's/views

So the views can get the properties/values they need without their own complex transformations against
the data they are passed from store subscriptions

In other words, the store-subscriptions at the view-level are COURSE and we don't want a bunch of complex
code in our VC's trying to reduce/distill/derive that course/big state, 
to figure out current data state of individual teams, games, prices, etc

So these read-only API's will give them clean answers 




