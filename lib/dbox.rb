ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$:.unshift File.join(ROOT_PATH, "lib")
$:.unshift File.join(ROOT_PATH, "vendor")

require "dropbox"
require "fileutils"
require "time"
require "yaml"
require "logger"
require "cgi"
require "sqlite3"
require "insensitive_hash_patched"

require "dbox/loggable"
require "dbox/utils"
require "dbox/api"
require "dbox/database"
require "dbox/db"
require "dbox/syncer"

module Dbox
  def self.authorize
    Dbox::API.authorize
  end

  def self.create(remote_path, local_path, params = {})
    log.debug "Creating (remote: #{remote_path}, local: #{local_path})"
    remote_path = clean_remote_path(remote_path)
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Syncer.create(remote_path, local_path, params)
  end

  def self.clone(remote_path, local_path, params = {})
    log.debug "Cloning (remote: #{remote_path}, local: #{local_path})"
    remote_path = clean_remote_path(remote_path)
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Syncer.clone(remote_path, local_path, params)
  end

  def self.pull(local_path, params = {})
    log.debug "Pulling (local: #{local_path})"
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Syncer.pull(local_path, params)
  end

  def self.clone_or_pull(remote_path, local_path, params = {})
    if exists?(local_path)
      pull(local_path, params)
    else
      clone(remote_path, local_path)
    end
  end

  def self.push(local_path, params = {})
    log.debug "Pushing (local: #{local_path})"
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Syncer.push(local_path, params)
  end

  def self.move(new_remote_path, local_path)
    log.debug "Moving (new remote: #{new_remote_path}, local: #{local_path})"
    new_remote_path = clean_remote_path(new_remote_path)
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Syncer.move(new_remote_path, local_path)
  end

  def self.exists?(local_path)
    local_path = clean_local_path(local_path)
    migrate_dbfile(local_path)
    Dbox::Database.exists?(local_path)
  end

  def self.delete(remote_path, local_path = nil)
    log.debug "Deleting (remote: #{remote_path})"
    remote_path = clean_remote_path(remote_path)
    Dbox::Syncer.api.delete_dir(remote_path)
    if local_path
      local_path = clean_local_path(local_path)
      log.debug "Deleting (local_path: #{local_path})"
      FileUtils.rm_rf(local_path) if File.exists?(local_path)
    end
  end

  def self.list(remote_path)
    files = Dbox::Syncer.api.list_folder(remote_path, recursive: false, get_all: true, include_deleted: false)
    files.each do |file|
      puts file.path_display.sub(/^.*\//, '')
    end
  end

  def self.metadata(remote_path)
    log.debug "Getting metadata for #{remote_path}"
    remote_path = clean_remote_path(remote_path)
    Dbox::Syncer.api.metadata(remote_path)
  end

  private

  def self.clean_remote_path(path)
    raise(ArgumentError, "Missing remote path") unless path
    path.sub(/\/$/,'')
    path[0].chr == "/" ? path : "/#{path}"
  end

  def self.clean_local_path(path)
    raise(ArgumentError, "Missing local path") unless path
    File.expand_path(path)
  end

  def self.migrate_dbfile(path)
    if Dbox::DB.exists?(path)
      log.warn "Old database file format found -- migrating to new database format"
      Dbox::Database.migrate_from_old_db_format(Dbox::DB.load(path))
      Dbox::DB.destroy!(path)
      log.warn "Migration complete"
    end
  end
end
