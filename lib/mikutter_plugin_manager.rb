require 'mikutter_plugin_manager/version'
require 'mikutter_plugin_manager/cli'
require 'yaml'
require 'date'
require 'git'
require 'fileutils'

module MikutterPluginManager
  # 各関数の return は成功したかどうかの判定とかかな
  # TODO: エラーハンドリングをどうにかするタイミングで対応

  ## 各サブコマンドから直接呼んだり、コードから呼んだりするのを想定している関数

  # plugins.yaml をカレントディレクトリに生成する
  def self.init(install_path = nil)
    yaml = {
      'creator' => ENV['USER'],
      'date' => Time.now.to_s,
      'plugins' => [
      ]
    }

    # ディレクトリのチェック
    unless Dir.exist?(install_path)
      puts 'ないのでディレクトリ作る'
      FileUtils.mkdir_p(install_path)
    end

    File.open(install_path + '/plugins.yaml', 'w') do |f|
      YAML.dump(yaml, f)
    end
  end

  # カレントディレクトリにある plugins.yaml を読み込み、指定した場所に各プラグインを clone する
  def self.install
    target_yaml_path = './plugins.yaml'
    unless File.exist?(target_yaml_path)
      puts 'plugins.yaml がないよ'

      return false
    end

    yaml = YAML.load_file(target_yaml_path)
    yaml['plugins'].each do |plugin|
      target_name = plugin['name']
      target_repo = plugin['repo'] # 存在するものか、有効な URL かのチェックが必要
      # name なしのときは repo から取らないといけない
      target_name = self.get_repo_name(target_repo) if target_name == nil
      g = Git.clone(target_repo, target_name, :path => './')
      puts "#{target_name} cloned from #{target_repo}"
    end

    return true
  end

  # インストール済みのプラグインの更新（plugins.yaml に追記された未 clone のものも取得する？）
  # TODO: lock ファイル的なものを使って制御（カレントディレクトリにあるこのファイルがあるところでのみ有効とか）
  # TODO: インストール先を変えるとつらいやーつ
  def self.update
    puts 'update'
    target_yaml_path = './plugins.yaml'
    unless File.exist?(target_yaml_path)
      puts 'plugins.yaml がないよ'

      return false
    end
  end

  # 指定した場所にあるすべてのプラグインを plugins.yaml に書く
  # TODO: git にないやつどうするんだ問題
  def self.export
    puts 'export'
    target_yaml_path = './plugins.yaml'
    unless File.exist?(target_yaml_path)
      puts 'plugins.yaml がないよ'

      return false
    end
  end

  # 指定した場所にプラグインを clone し、カレントディレクトリにある plugins.yaml に追記する
  def self.require(target_repo, target_name = nil)
    target_yaml_path = './plugins.yaml'
    unless File.exist?(target_yaml_path)
      puts 'plugins.yaml がないよ'

      return false
    end

    target_name = self.get_repo_name(target_repo) if target_name == nil
    g = Git.clone(target_repo, target_name, :path => './')

    yaml = YAML.load_file(target_yaml_path)

    new_plugin = {}
    new_plugin['name'] = target_name if target_name != nil
    new_plugin['repo'] = target_repo
    yaml['plugins'].push(new_plugin)
    File.open('./plugins.yaml', 'w') do |f|
      YAML.dump(yaml, f)
    end
  end

  ## utils 的な関数

  # リポジトリ URL の hoge.git から hoge を取る
  # hoge.git じゃないリポジトリとかだったら死ぬやつ
  # リポジトリの URL のみの場合に使う苦し紛れの対応
  def self.get_repo_name(repo_url)
    repo_url.split('/')[-1].split('.')[0]
  end
end
