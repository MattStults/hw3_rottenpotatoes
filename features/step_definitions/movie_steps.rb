# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert ((/#{e1}.*#{e2}/m =~ page.body) != nil)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  for rating in rating_list.split(" ") do
    step("#{((uncheck==nil)?"":"un")}check \"ratings[#{rating}]\"")
  end
end

Then /I should see the following ratings should be (un)?checked: (.*)/ do |uncheck, rating_list|
  for rating in rating_list.split(" ") do
    assert ((/<td>#{rating}<\/td>/ =~ page.body) != nil) ^ uncheck
    step("the \"ratings[#{rating}]\" checkbox should #{((uncheck==nil)?"":"not ")}be checked")
  end
end

Then /I should see the following movies: (.*)/ do |movie_list|
  for movie in movie_list.split(" ") do
    assert (/#{movie}/ =~ page.body) != nil
  end
end

Then /I should see all of the movies/ do
  assert page.has_css?("table#movies tr", :count => 1 + Movie.all.count)
end

Then /I should see no movies/ do
  assert page.has_css?("table#movies tr", :count => 1)
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  assert ((/Director:\s+#{director}/m =~ page.body) != nil)
end
