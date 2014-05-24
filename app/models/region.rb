class Region < GeoEntity
  # Область или областной центр
  self.table_name = 'region'
  self.primary_key= 'id'

  # Relationships
  # является частью/относится к стране/государству
  belongs_to :region, :foreign_key => 'owner'
  # имеет в районы и райцентры
  has_many :districts, foreign_key: 'owner'

  # Constraints
  #validates_numericality_of :owner, :grou_, :start_pstidx, :finish_pstidx, :pstidx_qty, {:allow_nil=>true}
  #validates_numericality_of :region_order
  #validates_presence_of :region_order
  #validates_uniqueness_of :name, :start_pstidx, :finish_pstidx
end

