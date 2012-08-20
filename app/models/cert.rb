class Cert < CouchRest::Model::Base
  timestamps!

  property :random, Float, :accessible => false

  before_create :set_random

  design do
    view :by_random
  end

  class << self
    def sample
      self.by_random.startkey(rand).first || self.by_random.first
    end

    def pick_from_pool
      cert = self.sample
      cert.destroy
      return cert
    rescue RESOURCE_NOT_FOUND
      retry if Cert.count > 0
      raise RECORD_NOT_FOUND
    end
  end

  def set_random
    self.random = rand
  end


end
