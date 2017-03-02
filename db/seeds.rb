# User seeds
users = User.create([{ name: "Snoopy", email: "snoopy@peanuts.com", 
											 password: "peanuts" },
										 { name: "Charlie Brown", email: "charlie@peanuts.com", 
											 password: "peanuts" },
										 { name: "Linus van Pelt", email: "linus@peanuts.com", 
											 password: "peanuts" },
										 { name: "Woodstock", email: "woodstock@peanuts.com", 
											 password: "peanuts" },
										 { name: "Lucy van Pelt", email: "lucy@peanuts.com", 
											 password: "peanuts" },
										 { name: "Schroeder", email: "schroeder@peanuts.com", 
											 password: "peanuts" },
										 { name: "Sally Brown", email: "sally@peanuts.com", 
											 password: "peanuts" },
										 { name: "Pig-Pen", email: "pigpen@peanuts.com", 
											 password: "peanuts" },
										 { name: "Peppermint Patty", email: "patty@peanuts.com", 
											 password: "peanuts" },
										 { name: "Violet Gray", email: "violet@peanuts.com", 
											 password: "peanuts" }])

# Post seeds
posts = Post.create([{ content: "The joy is in the playing.", user_id: 6 },
										 { content: "I got a rock.", user_id: 2 },
										 { content: "Happiness is a warm puppy", user_id: 5 },
										 { content: "It was a dark and stormy night...", 
										 	 user_id: 1 },
										 { content: "I was a victim of false doctrine.", 
										 	 user_id: 3 },
										 { content: "Stop calling me sir!", user_id: 9 },
										 { content: "That's the way it goes...", user_id: 2 },
										 { content: "Kiss her, you blockhead!", user_id: 7 },
										 { content: "There are three things I have learned never "\
										 	          "to discuss with people...religion, politics" \
										 	          "and the Great Pumpkin!", user_id: 3 }])


