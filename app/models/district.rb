class District < GeoEntity
  # район или районный центр
  self.table_name = 'region'
  self.primary_key= 'id'

  # Relationships
  # является частью/относится к области
  belongs_to :region, :foreign_key => 'owner'
  # имеет в составе села, поселки
  has_many :villages, :foreign_key => 'owner'

  def region_name
     Region.name
   end
end