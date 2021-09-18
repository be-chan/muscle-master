# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '~> 3.16.0'

# Capistranoのログの表示に利用する
set :application, 'muscle-master'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:be-chan/muscle-master.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'

# どの公開鍵を利用してデプロイするか
# ローカル用のデプロイ
# set :ssh_options, auth_methods: ['publickey'],
#                                   keys: ['~/.ssh/bechama.pem'] 

# CircleCI用のデプロイ
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/id_rsa_c4f2f04ca5ba8f69ff9ed6259050eaa8'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end