FactoryGirl.define do

  factory :item do
    title
    description
    price
    image_url "rhino_black.jpg"
  end

  sequence :title do |n|
    "#{n} Item"
  end

  sequence :description do |n|
    "#{n} Description"
  end

  sequence :price do |n|
    n * 1000
  end

  travesty_titles = ["Environmental 'Enhancements'",
                     "Endangered Species Culling",
                     "Political 'Pursuasion'",
                     "Big Pharm Phun",
                     "Crowd Funded, Prisoner Approved"]

  sequence :travesty_title, travesty_titles.cycle do |n|
    "#{n}"
  end

  factory :travesty do
    title { generate(:travesty_title) }

    factory :travesty_with_items do
      items { create_list(:item, 4) }
    end
  end

  factory :user do
    first_name
    last_name
    username
    role 0
    password "password"
  end

  sequence :first_name do |n|
    "#{n}First"
  end

  sequence :last_name do |n|
    "#{n}Last"
  end

  sequence :username do |n|
    "#{n}FirstLast"
  end

  factory :order do
    status "ordered"
    total_price 5000
  end

  factory :order_item do
    item_quantity 1
    item_price 1000
  end
end
