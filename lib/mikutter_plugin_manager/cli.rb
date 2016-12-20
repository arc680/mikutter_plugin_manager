# encoding: UTF-8

require 'thor'

module MikutterPluginManager
  class CLI < Thor
    desc "init", "create hoge.yaml"
    option :path, type: :string, default: File.expand_path('~/.mikutter/plugin')
    def init()
      MikutterPluginManager.init(options[:path])
      puts 'generated plugins.yaml'
    end

    desc "install", "install plugin from hoge.yaml"
    def install()
      puts 'installed all plugins from plugins.yaml' if MikutterPluginManager.install
    end

    desc "update", "update plugin from hoge.yaml"
    def update()
      MikutterPluginManager.update
    end

    desc "export", "export plugin to hoge.yaml"
    def export()
      MikutterPluginManager.export
    end

    desc "require", "install one plugin"
    def require(target_repo, target_name = nil)
      MikutterPluginManager.require(target_repo, target_name)
    end
  end
end
