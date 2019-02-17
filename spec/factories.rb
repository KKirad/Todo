FactoryBot.define do
  factory :todo_list do
    title {"Grocery"}
  end

  factory :todo_item do
  	association :todo_list
    content {"Rice"}
  end
  
end
