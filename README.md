# Book of Faces

Book of Faces is a social network web app based off of the widely used social network app, Facebook. Users can make a profile, send friend requests to other users, create posts, like and/or comment on other posts, and see a 'timeline' of all posts.

This is The Odin Project's [Final Ruby on Rails Project](http://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).

## Live App
See the app live [here](https://frozen-sands-98166.herokuapp.com/).

You can create your own account or sign in with one of the following sample accounts:

Email: snoopy@peanuts.com
Password: peanuts

Email: charlie@peanuts.com
Password: peanuts

## TODO
- Organize comments by date of post
- Fix error messages
- Notification tab functionality
- Add pagination for friend requests
- User can't friend someone that already friend him/her (fix uniqueness of friendship model)
- Use polymorphic association to make post allow either text OR photo
- After editing comments/posts, redirect back to previous page rather than root
- Unit tests to make sure associations are set up and deleting users deletes
 everything associated with that user