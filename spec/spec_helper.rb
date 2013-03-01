#
# Before running
#
# Make sure sqlite is installed
#
#   - brew install sqlite
#
# Make sure rspec gem is installed
#
#
require 'data_mapper'
require 'ysd_md_configuration'
require 'dm-encrypted'

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup :default, "sqlite3::memory:"
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize 

DataMapper.auto_migrate!


rsa_key = OpenSSL::PKey::RSA.generate(2048) 

Crypto.configure({:rsa_key => rsa_key,
  :aes_key => rsa_key.public_encrypt(Digest::SHA2.new(256).digest('password')),
  :aes_iv => rsa_key.public_encrypt(rand.to_s)})

