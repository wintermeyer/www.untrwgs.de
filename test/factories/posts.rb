FactoryGirl.define do
  factory :post do
    user nil
title "MyString"
abstract "MyString"
content "MyText"
state 1
likes_count 1
dislikes_count 1
  end

end
