class Package < ActiveRecord::Base
    validates :package_name, :version, presence: true
    enum status: { processing: 0, active: 1 }

    def self.processed
      where(status: 1)
    end
end
