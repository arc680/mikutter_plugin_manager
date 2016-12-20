# encoding: UTF-8

require 'thor'

module MikutterPluginManager
  class CLI < Thor
    desc "init", "create hoge.yml"
    option :path, type: :string, default: File.expand_path('~/.mikutter/plugin')
    def init()
      puts 'generated plugins.yml' if MikutterPluginManager.init(options[:path])
    end

    desc "install", "install plugin from hoge.yml"
    def install()
      puts 'installed all plugins from plugins.yml' if MikutterPluginManager.install
    end

    desc "update", "update plugin from hoge.yml"
    def update()
      MikutterPluginManager.update
    end

    desc "export", "export plugin to hoge.yml"
    def export()
      MikutterPluginManager.export
    end

    desc "require", "install one plugin"
    def require(target_repo, target_name = nil)
      MikutterPluginManager.require(target_repo, target_name)
    end
  end
end
