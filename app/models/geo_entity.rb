class GeoEntity < ActiveRecord::Base
  self.table_name = 'region'
  self.primary_key= 'id'
  self.inheritance_column = 'grou_'

  # Constraints
  validates_numericality_of :id, :start_pstidx, :finish_pstidx, :grou_, :owner
  validates_presence_of :id, :name, :grou_, :owner
  validates_uniqueness_of :id

  default_scope order: 'name ASC'

  TYPE_MAP = {
      0 => 'Country',
      1 => 'Region',
      2 => 'District',
      3 => 'Village'
  }

  class << self
    def find_sti_class(type)
      puts "#{type}"
      super(TYPE_MAP[type.to_i])
    end

    def sti_name
      TYPE_MAP.invert[self.name]
    end
  end

end