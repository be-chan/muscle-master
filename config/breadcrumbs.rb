crumb :memo_index do
  link "ホーム(メモ一覧)", memos_path
end

crumb :memo_new do  
  link "メモ追加", new_memo_path
  parent :memo_index
end

crumb :memo_edit do |memo|
  link "メモ編集", edit_memo_path(memo)
  parent :memo_index
end

crumb :memo_tweet_new do |memo|
  link "メモシェア投稿", new_memo_tweet_path(memo)
  parent :memo_index
end

crumb :tweet_index do 
  link "メモつぶやき一覧", tweets_path
  parent :memo_index
end

crumb :tweet_show do |tweet|
  link "つぶやき詳細", tweet_path(tweet)
  parent :tweet_index
end

crumb :mypage do 
  link "マイページ", user_path(current_user.id)
  parent :tweet_index 
end

crumb :user_edit do 
  link "ユーザー情報編集", edit_user_registration_path
  parent :mypage 
end

crumb :mypage_following do 
  link "#{current_user.nickname}さんのフォロー一覧", following_user_path(current_user.id)
  parent :mypage
end

crumb :mypage_followers do 
  link "#{current_user.nickname}さんのフォロワー一覧", followers_user_path(current_user.id)
  parent :mypage
end

crumb :user_page do |user|
  link "#{user.nickname}さんのページ", user_path(user.id)
  parent :tweet_index 
end

crumb :user_page_following do |user|
  link "#{user.nickname}さんのフォロー一覧", following_user_path(user.id)
  parent :user_page, user
end

crumb :user_page_followers do |user|
  link "#{user.nickname}さんのフォロワー一覧", followers_user_path(user.id)
  parent :user_page, user
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).