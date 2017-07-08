require 'yaml'

config  = YAML.load(File.read(File.join('config', 'database.yml')))
Lobster.connection = Sequel.connect(config)
Sequel.extension :migration


Sequel::Migrator.run(Lobster.connection, File.join('db', 'migrations')) if Lobster.connection
