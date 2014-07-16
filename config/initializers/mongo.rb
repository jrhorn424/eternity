include Mongo

mongo_client = MongoClient.new

version_store = mongo_client['iclaims']
VERSION_COLLECTION = version_store['versions']
