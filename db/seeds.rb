# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user_generation_count = 5

user_generation_count.times do |i|
  User.create(name: "Test User #{i}", email: "test_user_#{i}@example.com", password: '111111')
end

# レシピレコードの生成数
recipe_generation_count = 20

# サンプルはjpegファイルのみ
sample_recipe_images      = Dir.glob(Rails.root + "./test/fixtures/image/recipe/*jpg")
sample_recipe_step_images = Dir.glob(Rails.root + "./test/fixtures/image/recipe_step/*jpg")

ingredients = %w(牛肉 豚肉 鶏肉 ハム ソーセージ ベーコン ソーセージ 真鯛 鯵 鯖 にしん イカ 海老 渡り蟹 ほたて かぼちゃ なす 白菜 大根 じゃがいも たまねぎ 冬瓜 にんじん トマト イチゴ マンゴー すいか メロン 豆腐 納豆)
catch_copy  = %w(ふわふわ 特製 自家製)
make        = %w(唐揚げ 香草焼き フライ 姿焼き 煮付け ソテー サラダ グラタン パスタ カレー オムレツ ナムル 酢の物 うどん かけ蕎麦 ラーメン スープ シチュー パイ 包み焼き ケーキ プリン)
seasoning   = %w(醤油 みそ みりん 砂糖 塩 こしょう にんにく オリーブオイル コンソメ顆粒 鶏ガラスープのもと（顆粒） ごま油 粗挽き胡椒 バター チーズ 牛乳 小麦粉 片栗粉 ベーキングパウダー ウスターソース 中濃ソース マヨネーズ)
scale       = %w(大さじ 小さじ カップ)

class Recipe < ActiveRecord::Base
end
class RecipeStep < ActiveRecord::Base
end
class SeedPostImage < PostImage
  def image=(param)
    write_attribute(:image, param.read)
  end
end
recipe_generation_count.times do |i|

  user_id     = rand(1..user_generation_count)

  ing         = ingredients.sample
  mk          = make.sample
  recipe_name = ing + 'の' + mk

  recipe_image_file = File.new(sample_recipe_images.sample)

  recipe = Recipe.new(user_id: user_id, name: recipe_name, required_time: rand(1..12) * 10, summary: "おいしい#{recipe_name}のつくりかたです", serving_for: rand(1..5))
  recipe.save validate: false
  SeedPostImage.create(image: recipe_image_file, mime_type: 'image/jpeg', imageable_id: recipe.id, imageable_type: 'Recipe')


  RecipeIngredient.create(recipe_id: recipe.id, name: ing, quantity: rand(10..90).to_s + '0グラム')
  rand(2..10).times do |i|
    sea = seasoning.sample
    quan = scale.sample + ' ' + rand(1..5).to_s
    RecipeIngredient.create(recipe_id: recipe.id, name: sea, quantity: quan)
  end

  rand(1..10).times do |i|
    order = i + 1
    recipe_step_image_file  = File.new(sample_recipe_step_images.sample)
    recipe_step = RecipeStep.create(recipe_id: recipe.id, order: order, content: "\"STEP#{order}\" #{recipe_name}の作り方の説明文です。\n改行しました。\nユーザーが<b>HTMLタグを<br />入力しました。</b>\nユーザーが&copy;文字参照を入力しました。")
                  SeedPostImage.create(image: recipe_step_image_file, mime_type: 'image/jpeg', imageable_id: recipe_step.id, imageable_type: 'RecipeStep')
  end
end
